//  Created by Alexander Skorulis on 4/5/2025.

import Foundation

final class AttackExecutor {
    
    var random: RandomNumberGenerator
    
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
        let both: [any Combatant] = [attacker, defender]
        let eliminated = both.filter { $0.health.current <= 0 }.map { $0.id }
        return .init(context: context, eliminatedIDs: Set(eliminated))
    }
    
    private func execute<Attacker: Combatant, Defender: Combatant>(
        ability: AttackAbility,
        attacker: inout Attacker,
        defender: inout Defender
    ) -> AttackContext {
        var context = AttackContext()
        context.hitChance = self.hitChance(attacker: attacker, defender: defender, ability: ability, context: &context)
        context.hitRoll = Double.random(in: 0...1, using: &self.random)
        if context.hitRoll! > context.hitChance! {
            // Miss
            return context
        }
        let damage: Int
        switch ability {
        case let .unarmed(_, dmg):
            damage = dmg
        }
        defender.health -= damage
        context.damage = damage
        return context
    }
    
    func hitChance(
        attacker: Combatant,
        defender: Combatant,
        ability: AttackAbility,
        context: inout AttackContext
    ) -> Double {
        context.atk = attackValue(attacker: attacker, ability: ability)
        return hitChance(atk: context.atk!, def: 1)
    }
    
    func hitChance(atk: Int, def: Int) -> Double {
        return Double(atk) / Double(atk + def)
    }
    
    func attackValue(attacker: Combatant, ability: AttackAbility) -> Int {
        var base = 1
        if let skilled = attacker as? SkilledCombatant {
            if ability.attributes.contains(.unarmed) {
                base += skilled.value(.unarmed)
            }
        }
        
        return base
    }
}

