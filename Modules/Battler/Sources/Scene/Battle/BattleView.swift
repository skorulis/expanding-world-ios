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
        VStack(spacing: 8) {
            topSection
            
            Spacer()
            stats
            grid
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private var topSection: some View {
        if viewModel.player.health.current <= 0 {
            lossView
        } else if viewModel.currentMonster != nil {
            MonsterView(monsters: viewModel.fight.monsters)
        } else {
            winView
        }
    }
    
    private var winView: some View {
        VStack {
            Asset.fireworks.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
            Button(action: viewModel.complete) {
                Text("You Win")
                    .font(.title)
                    .foregroundColor(.red)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.red.opacity(0.2))
            )
        }
        
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
    
    @ViewBuilder
    private func monsterView(_ monster: Monster) -> some View {
        ZStack {
            monster.spec.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 200)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing) {
            ValueCircle(value: monster.health, color: .red)
        }
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
            VStack {
                action.image
                    .font(.system(size: 24))
                Text(action.name)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(8)
        }
    }
}

// MARK: - Previews

#Preview("Fight") {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let fight = BattlerFight.testFight()
    BattleView(
        viewModel: resolver.battleViewModel(player: .testPlayer(), fight: fight, resultHandler: { _ in})
    )
}

#Preview("Win") {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let fight = BattlerFight(monsters: [])
    BattleView(
        viewModel: resolver.battleViewModel(player: .testPlayer(), fight: fight, resultHandler: { _ in})
    )
}

#Preview("Loss") {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let fight = BattlerFight(monsters: [])
    var player = BattlerPlayer.testPlayer()
    player.health.current = 0
    return BattleView(
        viewModel: resolver.battleViewModel(player: player, fight: fight, resultHandler: { _ in})
    )
}

