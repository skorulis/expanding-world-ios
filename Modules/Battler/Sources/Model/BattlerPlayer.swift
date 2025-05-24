//  Created by Alexander Skorulis on 10/5/2025.

import Core
import Foundation

public struct BattlerPlayer: SkilledCombatant, Sendable {
    let id: UUID
    var health: CombatantValue = .init(10)
    var abilities: [AttackAbility] = [.unarmed(.punch, 2), .unarmed(.kick, 4)]
    var inventory: Inventory = .init()
    var skills: SkillDictionary
    var money: Int64
    
    init(money: Int64 = 100) {
        self.id = UUID()
        self.money = money
        self.skills = .init([.unarmed: 1])
    }
    
    func value(_ skill: Skill) -> Int {
        skills.value(skill)
    }
    
}
