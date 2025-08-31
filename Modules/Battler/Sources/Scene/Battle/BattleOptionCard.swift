//  Created by Alexander Skorulis on 29/6/2025.

import Foundation
import SwiftUI

struct AttackAbilityCard: View {
    
    let attackAbility: AttackAbility
    let chance: Double?
    let action: () -> Void
    let selected: Bool
    
    init(
        attackAbility: AttackAbility,
        chance: Double?,
        selected: Bool = false,
        action: @escaping () -> Void,
    ) {
        self.attackAbility = attackAbility
        self.chance = chance
        self.selected = selected
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack {
                attackAbility.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                Text(attackAbility.name)
                    .font(.caption)
                Text(text2)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(8)
        }
    }
    
    private var backgroundColor: Color {
        return selected ? Color.red.opacity(0.2) : Color.blue.opacity(0.2)
    }
    
    private var text2: String {
        var result = ""
        if let damage = attackAbility.damangeRangeString {
            result += "DMG: \(damage)"
        }
        if let chance {
            let chanceString = chance.formatted(
                .percent.precision(.fractionLength(fractionLength))
            )
            result += " \(chanceString)"
        }
        
        return result
    }
    
    private var fractionLength: Int {
        if let chance, chance < 0.01 {
            return 1
        } else {
            return 0
        }
    }
}

#Preview {
    HStack(spacing: 10) {
        AttackAbilityCard(
            attackAbility: .unarmed(.bite, 0...5),
            chance: 50,
            action: {}
        )
        
        AttackAbilityCard(
            attackAbility: .unarmed(.bite, 0...5),
            chance: nil,
            action: {}
        )
    }
    .padding(.horizontal, 16)
}
