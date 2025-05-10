//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

struct Monster: Combatant {
    let id: UUID
    let spec: MonsterSpec
    var health: CombatantValue = .init(10)
    var ability: AttackAbility { .physical(1) }
    
    init(spec: MonsterSpec) {
        self.spec = spec
        self.id = UUID()
    }
}
