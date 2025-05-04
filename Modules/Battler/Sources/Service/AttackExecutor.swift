//  Created by Alexander Skorulis on 4/5/2025.

import Foundation

final class AttackExecutor {
    
    func execute(attacker: inout Combatant, defender: inout Combatant) -> AttackResult {
        let ability = attacker.ability
        execute(ability: ability, attacker: &attacker, defender: &defender)
        let eliminated = [attacker, defender].filter { $0.health <= 0 }.map { $0.id }
        return .init(eliminatedIDs: Set(eliminated))
    }
    
    private func execute(ability: AttackAbility, attacker: inout Combatant, defender: inout Combatant) {
        switch ability {
        case let .physical(damage):
            defender.health -= damage
        }
    }
}

