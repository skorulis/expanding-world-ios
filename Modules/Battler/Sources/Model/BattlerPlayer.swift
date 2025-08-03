//  Created by Alexander Skorulis on 10/5/2025.

import Core
import Foundation

public struct BattlerPlayer: SkilledCombatant, Sendable {
    let id: UUID
    var health: CombatantValue = .init(10)
    var abilities: [AttackAbility] = [.unarmed(.kick, 1...3)]
    var inventory: Inventory = .init()
    var skills: SkillDictionary
    var money: Int64
    var xp: Int { 1 } // Not really used
    var name: String { "Player" }
    
    init(money: Int64 = 0, skills: SkillDictionary) {
        self.id = UUID()
        self.money = money
        self.skills = skills
    }
    
    func value(_ skill: Skill) -> Int {
        skills.value(skill)
    }
    
    mutating func addXP(_ xp: [Skill: Int]) {
        for (key, value) in xp {
            skills.add(skill: key, xp: value)
        }
    }
    
    func atkValue(using ability: AttackAbility) -> Int {
        var base = 3
        if ability.attributes.contains(.unarmed) {
            base += value(.unarmed)
        }
        
        return base
    }
    
    func defence(against: AttackAbility) -> Int {
        return 1
    }
    
    var level: Int {
        return skills.totalLevel
    }
    
    func allSkillEffects() -> [StatusEffect] {
        var result: [StatusEffect] = []
        for (key, value) in skills.skills {
            result.append(contentsOf: key.effects(level: value))
        }
        return result
    }
    
    func activeSkillEffects() -> [StatusEffect] {
        allSkillEffects().filter { effect in
            effect.conditions.allSatisfy { isConditionActive($0) }
        }
    }
    
    func isConditionActive(_ condition: StatusEffectCondition) -> Bool {
        switch condition {
        case .unarmed:
            return self.inventory.equipped(.mainHand) == nil
        }
    }
    
}

struct RoundStats {
    var moneyEarned: Int64 = 0
    var fightsWon: Int = 0
    var damageDealt: Int = 0
    var damageTaken: Int = 0
}
