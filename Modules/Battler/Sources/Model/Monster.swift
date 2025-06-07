//  Created by Alexander Skorulis on 26/4/2025.

import Foundation
import Core

struct Monster: Combatant, Identifiable, Sendable {
    let id: UUID
    let spec: MonsterSpec
    var health: CombatantValue
    let abilities: [AttackAbility]
    var xp: Int { spec.difficultyValue }
    
    init(spec: MonsterSpec) {
        self.spec = spec
        self.abilities = spec.abilities
        self.health = .init(spec.health)
        self.id = UUID()
    }
    
    // Monsters do not gain XP
    mutating func addXP(_ xp: [Skill: Int]) {}
    
    func defence(against: AttackAbility) -> Int {
        return spec.defence
    }
}
