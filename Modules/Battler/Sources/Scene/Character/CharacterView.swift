//  Created by Alexander Skorulis on 25/5/2025.

import Core
import DesignSystem
import SwiftUI

// MARK: - Memory footprint

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
                SkillView(
                    skill: skill,
                    state: viewModel.player.skills.state(skill: skill)
                )
            }
        }
        .padding(.horizontal, 16)
    }
}

private struct SkillView: View {
    let skill: Skill
    let state: SkillState
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(skill.name) - Level \(state.level)")
                .font(.headline)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: geometry.size.width * CGFloat(state.xp) / CGFloat(state.neededXP))
                    
                    
                }
                .overlay(
                    Text("\(state.xp)/\(state.neededXP) XP")
                        .font(.caption)
                        .padding(.horizontal, 4)
                )
                    
            }
            .frame(height: 20)
            .cornerRadius(4)
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    CharacterView(viewModel: assembler.resolver.characterViewModel())
}

