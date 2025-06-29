//  Created by Alexander Skorulis on 28/6/2025.

import Core
import DesignSystem
import SwiftUI

struct BattleSuccessView: View {
    let skillGain: [Skill: Int]
    let onContinue: () -> Void
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 0) {
                    Text("You Win")
                        .font(.title)
                        .bold()
                    Asset.fireworks.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding()
                    
                    
                    skillsView
                }
                .padding()
            }
            Button(action: onContinue) {
                Text("Continue")
            }
            .buttonStyle(RectangleButtonStyle())
            .padding()
        }
    }
    
    @ViewBuilder
    private var skillsView: some View {
        if skillGain.isEmpty {
            EmptyView()
        } else {
            VStack(spacing: 16) {
                Text("Skills")
                    .font(.headline)
                    .fontWeight(.bold)
                
                ForEach(sortedSkills) { skill in
                    skillRow(
                        skill: skill,
                        xp: skillGain[skill] ?? 0
                    )
                }
            }
        }
    }
    
    private func skillRow(skill: Skill, xp: Int) -> some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(skill.name)
                    .font(.headline)
                
                Text("XP \(xp)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private var sortedSkills: [Skill] {
        Array(skillGain.keys).sorted { s1, s2 in
            return s1.name < s2.name
        }
    }
}

#Preview {
    BattleSuccessView(
        skillGain: [
            .melee: 10,
            .toughness: 5
        ],
        onContinue: {}
    )
}
