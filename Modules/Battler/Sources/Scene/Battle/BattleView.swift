//  Created by Alexander Skorulis on 27/4/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

// View for performing a battle
@MainActor struct BattleView {
    @State var viewModel: BattleViewModel
}

// MARK: - Rendering

extension BattleView: View {
    
    var body: some View {
        if viewModel.currentMonster == nil && viewModel.player.health.current > 0 {
            BattleSuccessView(
                fight: viewModel.fight,
                skillGain: viewModel.totalSkillGain,
                onContinue: viewModel.complete
            )
        } else {
            fightView
        }
    }
    
    private var fightView: some View {
        VStack(spacing: 8) {
            MonsterView(
                monsters: viewModel.fight.monsters,
                selected: viewModel.selectedBinding
            )
            
            FightLogView(logs: viewModel.logs)
            stats
            grid
        }
        .padding(.horizontal, 16)
    }
    
    private var lossView: some View {
        Button(action: viewModel.complete) {
            Text("You Lose")
                .font(.title)
                .foregroundColor(.red)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.red.opacity(0.2))
        )
    }
    
    private var stats: some View {
        VStack(spacing: 8) {
            ValueBar(value: viewModel.player.health, color: .green)
        }
    }
    
    private var grid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
            ForEach(Array(viewModel.playerActions.indices), id: \.self) { index in
                icon(action: viewModel.playerActions[index])
            }
        }
    }
    
    private func icon(action: AttackAbility) -> some View {
        Button(action: {
            viewModel.perform(action: action)
        }) {
            AttackAbilityCard(
                attackAbility: action,
                chance: viewModel.hitChance(action: action),
                action: { viewModel.perform(action: action) }
            )
        }
    }
}

// MARK: - Previews

#Preview("Fight") {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let fight = BattlerFight.testFight()
    BattleView(
        viewModel: resolver.battleViewModel(fight: fight)
    )
}

#Preview("Win") {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let fight = BattlerFight(monsters: [], difficulty: 0)
    let viewModel = resolver.battleViewModel(fight: fight)
    viewModel.totalSkillGain = [.melee: 20]
    return BattleView(
        viewModel: viewModel
    )
}

#Preview("Loss") {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let fight = BattlerFight(monsters: [], difficulty: 0)
    var player = BattlerPlayer.testPlayer()
    player.health.current = 0
    return BattleView(
        viewModel: resolver.battleViewModel(fight: fight)
    )
}

