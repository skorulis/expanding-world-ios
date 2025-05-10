//  Created by Alexander Skorulis on 10/5/2025.

import Foundation

public struct BattlerPlayer: Combatant, Sendable {
    let id: UUID
    var health: CombatantValue = .init(10)
    var ability: AttackAbility = .physical(2)
    
    init() {
        self.id = UUID()
    }
    
}
