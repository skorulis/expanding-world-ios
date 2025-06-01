//  Created by Alexander Skorulis on 4/5/2025.

import Core
import Foundation
import SwiftUI

enum AttackAbility {
    case unarmed(UnarmedType, ClosedRange<Int>)
    case weapon(Item.Instance)

    var image: Image {
        switch self {
        case let .unarmed(type, _):
            return type.image
        case let .weapon(item):
            return item.type.icon
        }
    }

    var name: String {
        switch self {
        case let .unarmed(type, _):
            return type.attackDetails.action
        case let .weapon(item):
            return item.type.attack!.action
        }
    }
    
    var details: AttackDetails {
        switch self {
        case let .unarmed(type, _):
            return type.attackDetails
        case let .weapon(weapon):
            return weapon.type.attack!
        }
    }
    
    var attributes: Set<Attribute> {
        switch self {
        case .unarmed:
            return [.physical, .unarmed]
        case .weapon:
            // TODO: Pull attributes from the item
            return []
        }
    }
    
    var damageRange: ClosedRange<Int>? {
        switch self {
        case .unarmed(_, let closedRange):
            closedRange
        case .weapon(let instance):
            instance.type.attack!.damage
        }
    }
    
    var damangeRangeString: String? {
        guard let damageRange else { return nil }
        if damageRange.lowerBound == damageRange.upperBound {
            return "\(damageRange.lowerBound)"
        }
        return "\(damageRange.lowerBound)-\(damageRange.upperBound)"
    }

}

extension AttackAbility {
    
    enum Attribute {
        case physical
        case unarmed
        case melee
        case bladed
    }
}

extension AttackAbility {
    enum UnarmedType {
        case punch
        case kick
        case bite
        case slap
        
        var image: Image {
            switch self {
            case .punch:
                return Image(systemName: "figure.boxing")
            case .kick:
                return Image(systemName: "figure.kickboxing")
            case .bite:
                return Image(systemName: "mouth.fill")
            case .slap:
                return Image(systemName: "tropicalstorm.circle.fill")
            }
        }
        
        var attackDetails: AttackDetails {
            switch self {
            case .punch:
                return AttackDetails(
                    action: "Punch",
                    damage: 1...3,
                    damageBonuses: [.unarmed: 1, .melee: 1],
                    baseAttack: 1,
                    attackBonuses: [.unarmed: 1, .melee: 1],
                )
            case .kick:
                return AttackDetails(
                    action: "Kick",
                    damage: 1...4,
                    baseAttack: 1
                )
            case .bite:
                return AttackDetails(
                    action: "Bite",
                    damage: 1...3,
                    baseAttack: 1
                )
            case .slap:
                return AttackDetails(
                    action: "Slap",
                    damage: 1...4,
                    baseAttack: 4
                )
            }
        }
    }
}
