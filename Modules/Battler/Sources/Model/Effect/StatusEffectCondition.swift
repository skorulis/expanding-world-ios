//  Created by Alexander Skorulis on 3/8/2025.

import Foundation

// Condition which causes a status effect to only apply in certain conditions
public enum StatusEffectCondition: Equatable, Sendable {
    // No weapons in hands
    case unarmed
    
    // Blade in the main hand
    case blades
}

extension StatusEffectCondition {
    var description: String {
        switch self {
        case .unarmed:
            return "unarmed"
        case .blades:
            return "using a bladed weapon"
        }
    }
}
