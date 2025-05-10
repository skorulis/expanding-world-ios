//  Created by Alexander Skorulis on 4/5/2025.

import Foundation

final class AttackExecutor {
    
    func execute<Attacker: Combatant, Defender: Combatant>(
        attacker: inout Attacker,
        defender: inout Defender
    ) -> AttackResult {
        let ability = attacker.ability
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
        case let .physical(damage):
            defender.health -= damage
        }
    }
}

