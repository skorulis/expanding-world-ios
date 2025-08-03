//  Created by Alexander Skorulis on 25/5/2025.

import Core
import DesignSystem
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct CharacterView {
    @State var viewModel: CharacterViewModel
}

// MARK: - Rendering

extension CharacterView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(title: "Character", backAction: { viewModel.coordinator?.pop() })
        } content: {
            VStack {
                skills
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var skills: some View {
        VStack {
            ForEach(viewModel.knownSkills) { skill in
                skillButton(skill: skill)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func skillButton(skill: Skill) -> some View {
        Button(action: { viewModel.showDetails(skill: skill) }) {
            HStack {
                SkillView(
                    skill: skill,
                    state: viewModel.player.skills.state(skill: skill)
                )
                
                Image(systemName: "chevron.forward")
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    CharacterView(viewModel: assembler.resolver.characterViewModel())
}

