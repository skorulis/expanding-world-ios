//  Created by Alexander Skorulis on 14/7/2025.

import Core
import Foundation

enum ShopSpec: CaseIterable {
    case generalStore
    case lightTemple
    case warTemple
    
    var name: String {
        switch self {
        case .lightTemple:
            return "Temple of Light"
        case .warTemple:
            return "Temple of War"
        case .generalStore:
            return "General Store"
        }
    }
    
    var possibleBuffs: [BuffSpec] {
        switch self {
        case .lightTemple:
            return [
                .init(
                    buff: .init(name: "Holy Safety", effect: .defence(3), duration: .battles(1)),
                    cost: 5
                )
            ]
        case .warTemple:
            return [
                .init(
                    buff: .init(name: "Fury", effect: .attack(3), duration: .battles(1)),
                    cost: 5
                )
            ]
        default:
            return []
        }
    }
    
    var possibleItems: [ItemSpec] {
        switch self {
        case .generalStore:
            return [
                .init(item: .leatherArmor, count: 1),
                .init(item: .stew, count: 1),
                .init(item: .copperDagger, count: 1),
            ]
        default:
            return []
        }
    }
}

extension ShopSpec {
    struct ItemSpec {
        let item: Item
        let count: Int
    }
    
    struct BuffSpec {
        let buff: StatusEffect
        let cost: Int
    }
}
