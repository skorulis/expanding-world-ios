//  Created by Alexander Skorulis on 4/5/2025.

import Core
import Foundation

struct AttackResult {
    let context: AttackContext
    let eliminatedIDs: Set<UUID>
}

struct AttackContext {
    let attacker: Combatant
    let defender: Combatant
    var atk: Int?
    var def: Int?
    var hitChance: Double?
    var hitRoll: Double?
    var damage: Int?
    var attackerSkillXP: [Skill: Int] = [:]
    
    init(attacker: Combatant, defender: Combatant) {
        self.attacker = attacker
        self.defender = defender
    }
    
    mutating func addAttackerXP(skill: Skill, xp: Double) {
        let xpInt = Int(round(xp))
        guard xpInt > 0 else { return }
        attackerSkillXP[skill] = (attackerSkillXP[skill] ?? 0) + xpInt
    }
    
    func logAttack() {
        if let atk {
            print("ATK: \(atk)")
        }
        if let def {
            print("DEF: \(def)")
        }
        
        if let hitChance, let hitRoll {
            print("HIT CHANCE: \(hitChance) / \(hitRoll)")
        }
        
        if let damage {
            print("DAMAGE: \(damage)")
        }
        
        if !attackerSkillXP.isEmpty {
            let items = attackerSkillXP.map { "\($0.key): \($0.value)" }
            print("SKILL GAIN: \(items.joined(separator: ", "))")
        }
    }
    
}
