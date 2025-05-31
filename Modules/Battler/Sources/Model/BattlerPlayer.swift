//  Created by Alexander Skorulis on 10/5/2025.

import Core
import Foundation

public struct BattlerPlayer: SkilledCombatant, Sendable {
    let id: UUID
    var health: CombatantValue = .init(10)
    var abilities: [AttackAbility] = [.unarmed(.kick, 4)]
    var inventory: Inventory = .init()
    var skills: SkillDictionary
    var money: Int64
    var xp: Int { 1 } // Not really used
    
    init(money: Int64 = 100, skills: SkillDictionary) {
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
    
}
