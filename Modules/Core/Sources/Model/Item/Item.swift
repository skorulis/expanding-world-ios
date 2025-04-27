//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

public enum Item: Codable {
    case grog
    case stew
}

extension Item {
    
    public enum Action {
        case consume
    }
    
    public enum Category {
        case food
        
        public var color: Color {
            switch self {
            case .food:
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
    
    public struct Instance: Identifiable, Codable {
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
        }
    }
    
    public var description: String {
        switch self {
        case .grog:
            return "Alcohol with a dubious composition"
        case .stew:
            return ""
        }
    }
    
    public var icon: Image {
        switch self {
        case .grog:
            return Image(systemName: "mug.fill")
        case .stew:
            return Image(systemName: "carrot.fill")
        }
    }
    
    public var rarity: Item.Rarity {
        switch self {
        case .grog, .stew:
            return .poor
        }
    }
    
    public var category: Item.Category {
        switch self {
        case .grog, .stew:
            return .food
        }
    }
    
    public var basePrice: Int64 {
        switch self {
        case .grog:
            return 2
        case .stew:
            return 3
        }
    }
    
    
}

// MARK: - Consumption

extension Item {
    public var consumableString: String? {
        switch self {
        case .grog:
            return "Drink"
        case .stew:
            return "Eat"
        }
    }
    
    public var consumptionEffects: [ItemEffect] {
        switch self {
        case .grog:
            [ItemEffect.addStatus(.intoxication, 1)]
        case .stew:
            [ItemEffect.addStatus(.satiation, 2)]
        }
    }
    
    public var consumptionTime: Int64 {
        switch self {
        case .grog: return 90
        case .stew: return 120
        }
    }
}
