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
    let ability: AttackAbility
    var atk: Int?
    var def: Int?
    var hitChance: Double?
    var hitRoll: Double?
    var damage: Int?
    var attackerSkillXP: [Skill: Int] = [:]
    var defenderSkillXP: [Skill: Int] = [:]
    
    init(attacker: Combatant, defender: Combatant, ability: AttackAbility) {
        self.attacker = attacker
        self.defender = defender
        self.ability = ability
    }
    
    mutating func addAttackerXP(skill: Skill, difficulty: Double) {
        guard attackerGainsXP else { return }
        let skillGain = skill.difficultyToXP(difficulty) * Double(defender.xp)
        addAttackerXP(skill: skill, xp: skillGain)
    }
    
    mutating func addAttackerXP(skill: Skill, xp: Double) {
        let xpInt = Int(round(xp))
        guard xpInt > 0 else { return }
        attackerSkillXP[skill] = (attackerSkillXP[skill] ?? 0) + xpInt
    }
    
    mutating func addDefenderXP(skill: Skill, difficulty: Double) {
        guard defenderGainsXP else { return }
        let skillGain = skill.difficultyToXP(difficulty) * Double(attacker.xp)
        addDefenderXP(skill: skill, xp: skillGain)
    }
    
    mutating func addDefenderXP(skill: Skill, xp: Double) {
        let xpInt = Int(round(xp))
        guard xpInt > 0 else { return }
        defenderSkillXP[skill] = (defenderSkillXP[skill] ?? 0) + xpInt
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
        
        if !attackerSkillXP.isEmpty && attackerGainsXP {
            let items = attackerSkillXP.map { "\($0.key): \($0.value)" }
            print("SKILL GAIN: \(items.joined(separator: ", "))")
        }
        if !defenderSkillXP.isEmpty && defenderGainsXP {
            let items = defenderSkillXP.map { "\($0.key): \($0.value)" }
            print("SKILL GAIN: \(items.joined(separator: ", "))")
        }
    }
    
    var attackerGainsXP: Bool {
        return attacker is SkilledCombatant
    }
    
    var defenderGainsXP: Bool {
        return defender is SkilledCombatant
    }
    
}
