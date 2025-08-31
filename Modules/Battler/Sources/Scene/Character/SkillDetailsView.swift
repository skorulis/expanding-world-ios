//  Created by Alexander Skorulis on 3/8/2025.

import DesignSystem
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct SkillDetailsView {
    @State var viewModel: SkillDetailsViewModel
}

// MARK: - Rendering

extension SkillDetailsView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(
                title: "\(viewModel.skill.name)",
                backAction: { viewModel.coordinator?.pop() }
            )
        } content: {
            content
                .padding(.horizontal, 16)
        } footer: {
            footer
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.skill.description)
            
            if viewModel.player.skills.isKnown(skill: viewModel.skill) {
                SkillView(
                    skill: viewModel.skill,
                    state: viewModel.state
                )
            }
            Text("Bonuses at level \(viewModel.level)")
                .font(.title)
            ForEach(Array(viewModel.effects.indices), id: \.self) { index in
                effectView(viewModel.effects[index])
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func effectView(_ effect: StatusEffect) -> some View {
        Text(effect.skillDescription)
    }
    
    @ViewBuilder
    private var footer: some View {
        if viewModel.showPurchase {
            Button(action: viewModel.buy) {
                HStack {
                    Text("Buy")
                    MoneyView(amount: viewModel.skill.purchaseCost)
                }
            }
            .buttonStyle(RectangleButtonStyle())
            .disabled(viewModel.player.money < viewModel.skill.purchaseCost)
        } else {
            EmptyView()
        }
    }
}

extension StatusEffect {
    var skillDescription: String {
        var string = self.effect.description
        if conditions.count > 0 {
            let combinedConditions = conditions.map { $0.description}
                .joined(separator: " and ")
            string += " when \(combinedConditions)"
        }
        return string
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    SkillDetailsView(
        viewModel: assembler.resolver.skillDetailsViewModel(skill: .unarmed, showPurchase: true)
    )
}

