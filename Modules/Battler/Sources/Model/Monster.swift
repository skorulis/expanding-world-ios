//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

struct Monster: Combatant, Identifiable {
    let id: UUID
    let spec: MonsterSpec
    var health: CombatantValue = .init(10)
    var abilities: [AttackAbility] { [.unarmed(.punch, 1)] }
    
    init(spec: MonsterSpec) {
        self.spec = spec
        self.id = UUID()
    }
}
