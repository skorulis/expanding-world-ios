//  Created by Alexander Skorulis on 3/8/2025.

import Core
import Foundation

extension Skill {
    func effects(level: Int) -> [StatusEffect] {
        switch self {
        case .unarmed:
            return [
                StatusEffect(
                    name: "Unarmed attack",
                    effect: .attack(level),
                    conditions: [.unarmed],
                    duration: .forever
                ),
                StatusEffect(
                    name: "Unarmed defence",
                    effect: .defence(level),
                    conditions: [.unarmed],
                    duration: .forever
                ),
            ]
        case .toughness:
            return []
        case .blades:
            return [
                StatusEffect(
                    name: "Attack",
                    effect: .attack(level),
                    conditions: [.blades],
                    duration: .forever
                ),
            ]
        case .shield:
            return []
        case .melee:
            return []
        }
    }
}
