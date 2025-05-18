//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

public enum Item: Codable, Sendable {
    case grog
    case stew
    case leatherArmor
}

extension Item {
    
    public enum Action {
        case consume
    }
    
    public enum Category {
        case food
        case armor
        
        public var color: Color {
            switch self {
            case .food:
                return .brown
            case .armor:
                return .brown
            }
        }
    }
    
    public enum Rarity {
        case poor
        case common
        case uncommon
        case rare
        case epic
        case legendary
        case heirloom
        
        public var color: Color {
            switch self {
            case .poor:
                return .gray
            case .common:
                return .white
            case .uncommon:
                return .green
            case .rare:
                return .blue
            case .epic:
                return .purple
            case .legendary:
                return .orange
            case .heirloom:
                return .yellow
            }
        }
    }
    
    public struct Instance: Identifiable, Codable, Sendable {
        public let type: Item
        public var amount: Int
        
        public init(type: Item, amount: Int) {
            self.type = type
            self.amount = amount
        }
        
        public var id: Item { type }
        
        public var baseCost: Int64 {
            return type.basePrice * Int64(amount)
        }
    }
}

extension Item {
    public var name: String {
        switch self {
        case .grog:
            return "Grog"
        case .stew:
            return "Stew"
        case .leatherArmor:
            return "Leather Armor"
        }
    }
    
    public var description: String {
        switch self {
        case .grog:
            return "Alcohol with a dubious composition"
        case .stew:
            return ""
        case .leatherArmor:
            return "Armor made from leather"
        }
    }
    
    public var icon: Image {
        switch self {
        case .grog:
            return Image(systemName: "mug.fill")
        case .stew:
            return Image(systemName: "carrot.fill")
        default:
            return Asset.Item.leatherArmor.swiftUIImage
        }
    }
    
    public var rarity: Item.Rarity {
        switch self {
        case .grog, .stew:
            return .poor
        case .leatherArmor:
            return .common
        }
    }
    
    public var category: Item.Category {
        switch self {
        case .grog, .stew:
            return .food
        case .leatherArmor:
            return .armor
        }
    }
    
    public var basePrice: Int64 {
        switch self {
        case .grog:
            return 2
        case .stew:
            return 3
        case .leatherArmor:
            return 50
        }
    }
    
    
}

// MARK: - Consumption

public struct Consumption {
    public let action: String
    public let effects: [ItemEffect]
    public let time: Int64

    public init(action: String, effects: [ItemEffect], time: Int64) {
        self.action = action
        self.effects = effects
        self.time = time
    }
}

extension Item {
    public var consumption: Consumption? {
        switch self {
        case .grog:
            return Consumption(
                action: "Drink",
                effects: [ItemEffect.addStatus(.intoxication, 1)],
                time: 90
            )
        case .stew:
            return Consumption(
                action: "Eat",
                effects: [ItemEffect.addStatus(.satiation, 2)],
                time: 120
            )
        default:
            return nil
        }
    }
}
