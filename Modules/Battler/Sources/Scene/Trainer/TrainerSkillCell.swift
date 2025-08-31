//  Created by Alexander Skorulis on 31/8/2025.

import Core
import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct TrainerSkillCell {
    let skill: Skill
}

// MARK: - Rendering

extension TrainerSkillCell: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(skill.name)
                    .bold()
                Text(skill.description)
            }
            Spacer()
            MoneyView(amount: skill.purchaseCost)
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(Color.black)
    }
}

// MARK: - Previews

#Preview {
    TrainerSkillCell(skill: .blades)
}

