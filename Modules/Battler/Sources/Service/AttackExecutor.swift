//  Created by Alexander Skorulis on 4/5/2025.

import Foundation

final class AttackExecutor {
    
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
        
        execute(ability: ability, attacker: &attacker, defender: &defender)
        let both: [any Combatant] = [attacker, defender]
        let eliminated = both.filter { $0.health.current <= 0 }.map { $0.id }
        return .init(eliminatedIDs: Set(eliminated))
    }
    
    private func execute<Attacker: Combatant, Defender: Combatant>(
        ability: AttackAbility,
        attacker: inout Attacker,
        defender: inout Defender
    ) {
        switch ability {
        case let .unarmed(_, damage):
            defender.health -= damage
        }
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

