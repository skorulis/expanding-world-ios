//  Created by Alexander Skorulis on 4/5/2025.

import Core
import Foundation

final class AttackExecutor {
    
    var random: RandomNumberGenerator
    let debug: Bool = true
    
    init(random: RandomNumberGenerator) {
        self.random = random
    }
    
    func execute<Attacker: Combatant, Defender: Combatant>(
        attacker: inout Attacker,
        defender: inout Defender
    ) -> AttackResult {
        guard let ability = attacker.abilities.randomElement() else {
            fatalError("Attacker has no abilities")
        }
        return self.execute(attacker: &attacker, defender: &defender, ability: ability)
    }
    
    func execute<Attacker: Combatant, Defender: Combatant>(
        attacker: inout Attacker,
        defender: inout Defender,
        ability: AttackAbility
    ) -> AttackResult {
        let context = execute(ability: ability, attacker: &attacker, defender: &defender)
        attacker.addXP(context.attackerSkillXP)
        defender.addXP(context.defenderSkillXP)
        let both: [any Combatant] = [attacker, defender]
        let eliminated = both.filter { $0.health.current <= 0 }.map { $0.id }
        return .init(context: context, eliminatedIDs: Set(eliminated))
    }
    
    private func execute<Attacker: Combatant, Defender: Combatant>(
        ability: AttackAbility,
        attacker: inout Attacker,
        defender: inout Defender
    ) -> AttackContext {
        var context = AttackContext(attacker: attacker, defender: defender, ability: ability)
        context.hitChance = self.hitChance(context: context)
        context.hitRoll = Double.random(in: 0...1, using: &self.random)
        if context.hitRoll! > context.hitChance! {
            // Miss
            context.logs.append(.init(message: missMessage(context: context)))
            return context
        }
        let damage: Int
        switch ability {
        case let .unarmed(_, dmg):
            context.addAttackerXP(skill: .unarmed, difficulty: (1 - context.hitChance!))
            damage = dmg.randomElement(using: &self.random)!
        case let .weapon(item):
            damage = item.type.attack!.damage.randomElement(using: &self.random)!
        case let .monsterSkill(_, details):
            damage = details.damage.randomElement(using: &self.random)!
        }
        context.logs.append(.init(message: hitMessage(context: context, ability: ability, damage: damage)))
        context.addDefenderXP(
            skill: .toughness,
            difficulty: defender.health.percentage(amount: damage)
        )
        
        defender.health -= damage
        context.damage = damage
        return context
    }
    
    func hitChance(
        context: AttackContext
    ) -> Double {
        return hitChance(atk: context.atk!, def: context.def!)
    }
    
    func hitChance(atk: Int, def: Int) -> Double {
        return Double(atk) / Double(atk + def)
    }
    
    func difficultyToSkillMultiplier(skill: Skill, diff: Double) -> Double {
        return skill.difficultyToXP(diff)
    }
    
    private func hitMessage(context: AttackContext, ability: AttackAbility, damage: Int) -> String {
        var result = "\(context.attacker.name) \(ability.verb) \(context.defender.name) for \(damage) damage"
        if debug {
            result += " (\(context.hitChanceString))"
        }
        return result
    }
    
    private func missMessage(context: AttackContext) -> String {
        var result = "\(context.attacker.name) misses"
        if debug {
            result += " (\(context.hitChanceString))"
        }
        return result
    }
}
