//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

enum Item: Codable {
    case grog
    case stew
}

extension Item {
    
    enum Action {
        case consume
    }
    
    enum Category {
        case food
        
        var color: Color {
            switch self {
            case .food:
                return .brown
            }
        }
    }
    
    enum Rarity {
        case poor
        case common
        case uncommon
        case rare
        case epic
        case legendary
        case heirloom
        
        var color: Color {
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
    
    struct Instance: Identifiable, Codable {
        let type: Item
        var amount: Int
        
        var id: Item { type }
        
        var baseCost: Int64 {
            return type.basePrice * Int64(amount)
        }
    }
}

extension Item {
    var name: String {
        switch self {
        case .grog:
            return "Grog"
        case .stew:
            return "Stew"
        }
    }
    
    var description: String {
        switch self {
        case .grog:
            return "Alcohol with a dubious composition"
        case .stew:
            return ""
        }
    }
    
    var icon: Image {
        switch self {
        case .grog:
            return Image(systemName: "mug.fill")
        case .stew:
            return Image(systemName: "carrot.fill")
        }
    }
    
    var rarity: Item.Rarity {
        switch self {
        case .grog, .stew:
            return .poor
        }
    }
    
    var category: Item.Category {
        switch self {
        case .grog, .stew:
            return .food
        }
    }
    
    var basePrice: Int64 {
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
    var consumableString: String? {
        switch self {
        case .grog:
            return "Drink"
        case .stew:
            return "Eat"
        }
    }
    
    var consumptionEffects: [ItemEffect] {
        switch self {
        case .grog:
            [ItemEffect.addStatus(.intoxication, 1)]
        case .stew:
            [ItemEffect.addStatus(.satiation, 2)]
        }
    }
    
    var consumptionTime: Int64 {
        switch self {
        case .grog: return 90
        case .stew: return 120
        }
    }
}
