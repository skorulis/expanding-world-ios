//  Created by Alexander Skorulis on 31/8/2025.

import DesignSystem
import SwiftUI

// MARK: - Memory footprint
@MainActor struct CharacterAbilitiesView {
    @State var viewModel: CharacterAbilitiesViewModel
}

// MARK: - Rendering

extension CharacterAbilitiesView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(
                title: "Abilities",
                backAction: { viewModel.coordinator?.pop() }
            )
        } content: {
            content
        }
    }
    
    private var content: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(viewModel.player.allActions.indices), id: \.self) { index in
                        AttackAbilityCard(
                            attackAbility: viewModel.player.allActions[index],
                            chance: nil,
                            selected: index == viewModel.selectedIndex,
                            action: { viewModel.select(index: index) }
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            details(ability: viewModel.selectedAbility)
        }
    }
    
    private func details(ability: AttackAbility) -> some View {
        VStack {
            if let atk = viewModel.context.atk {
                Text("ATK: \(atk)")
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    CharacterAbilitiesView(viewModel: assembler.resolver.characterAbilitiesViewModel())
}

