//  Created by Alexander Skorulis on 4/5/2025.

import Core
import DesignSystem
import Foundation

protocol Combatant {
    var id: UUID { get }
    var health: CombatantValue { get set }
    var abilities: [AttackAbility] { get }
    var xp: Int { get }
    var name: String { get }
    mutating func addXP(_ xp: [Skill: Int])
    
    func atkValue(using: AttackAbility) -> Int
    func defValue(against: AttackAbility) -> Int
}

protocol SkilledCombatant: Combatant {
    func value(_ skill: Skill) -> Int
}

// Used for Health or Mana
struct CombatantValue: CurrentValueType {
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
    
    func percentage(amount: Int) -> Double {
        return Double(amount) / Double(limit)
    }
    
    mutating func refill() {
        current = limit
    }
    
}
