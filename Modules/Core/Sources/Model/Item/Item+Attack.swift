//  Created by Alexander Skorulis on 26/5/2025.

import Foundation

// MARK: - Attack

public extension Item {
    
    public var attack: AttackDetails? {
        switch self {
        case .copperDagger:
            return AttackDetails(
                action: "Stab",
                verb: "stabs",
                damage: 2...4,
                damageBonuses: [
                    .blades: 1
                ],
                baseAttack: 1,
                attackBonuses: [
                    .blades: 2,
                    .melee: 1
                ]
            )
        default:
            return nil
        }
    }
}

public struct AttackDetails: Sendable {
    public let action: String
    public let verb: String
    public let damage: ClosedRange<Int>
    public let damageBonuses: [Skill: Int]
    public let baseAttack: Int
    public let attackBonuses: [Skill: Int]
    
    public init(
        action: String,
        verb: String,
        damage: ClosedRange<Int>,
        damageBonuses: [Skill : Int] = [:],
        baseAttack: Int,
        attackBonuses: [Skill : Int] = [:]
    ) {
        self.action = action
        self.verb = verb
        self.damage = damage
        self.damageBonuses = damageBonuses
        self.baseAttack = baseAttack
        self.attackBonuses = attackBonuses
    }
}
