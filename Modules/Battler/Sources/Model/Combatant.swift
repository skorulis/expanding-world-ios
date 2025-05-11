//  Created by Alexander Skorulis on 4/5/2025.

import Foundation

protocol Combatant {
    var id: UUID { get }
    var health: CombatantValue { get set }
    var abilities: [AttackAbility] { get }
}

// Used for Health or Mana
struct CombatantValue {
    var current: Int
    let limit: Int
    
    init(current: Int, limit: Int) {
        self.current = current
        self.limit = limit
    }
    
    init(_ value: Int) {
        self.current = value
        self.limit = value
    }

    static func -= (lhs: inout CombatantValue, rhs: Int) {
        lhs.current = max(0, lhs.current - rhs)
    }
    
    var string: String {
        return "\(current)/\(limit)"
    }
    
    var fraction: CGFloat {
        CGFloat(current) / CGFloat(limit)
    }
    
}
