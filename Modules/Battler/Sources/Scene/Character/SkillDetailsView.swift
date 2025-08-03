//  Created by Alexander Skorulis on 3/8/2025.

import DesignSystem
import SwiftUI

// MARK: - Memory footprint

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
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            SkillView(
                skill: viewModel.skill,
                state: viewModel.state
            )
            Text("Bonuses")
                .font(.title)
            ForEach(Array(viewModel.effects.indices), id: \.self) { index in
                effectView(viewModel.effects[index])
            }
        }
    }
    
    private func effectView(_ effect: StatusEffect) -> some View {
        Text(effect.skillDescription)
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
        viewModel: assembler.resolver.skillDetailsViewModel(skill: .unarmed)
    )
}

