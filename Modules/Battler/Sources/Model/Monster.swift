//  Created by Alexander Skorulis on 26/4/2025.

import Foundation
import Core

struct Monster: Combatant, Identifiable {
    let id: UUID
    let spec: MonsterSpec
    var health: CombatantValue = .init(10)
    let abilities: [AttackAbility]
    var xp: Int { spec.difficultyValue }
    
    init(spec: MonsterSpec) {
        self.spec = spec
        self.abilities = spec.abilities
        self.id = UUID()
    }
    
    // Monsters do not gain XP
    mutating func addXP(_ xp: [Skill: Int]) {}
}
