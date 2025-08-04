//  Created by Alexander Skorulis on 3/8/2025.

import Core
import SwiftUI

struct SkillView: View {
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
        .foregroundStyle(Color.black)
    }
}

#Preview {
    let assembler = BattlerAssembly.testing()
    VStack {
        SkillView(
            skill: .unarmed,
            state: SkillState(level: 1, xp: 0)
        )
        
        SkillView(
            skill: .melee,
            state: SkillState(level: 4, xp: 20)
        )
    }
    
}

