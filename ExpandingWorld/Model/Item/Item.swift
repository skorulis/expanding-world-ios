//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

enum Item {
    case grog
    case stew
}

extension Item {
    
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
    
    struct Instance: Identifiable {
        let type: Item
        let amount: Int
        
        var id: Item { type }
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
