//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import SwiftUI

/// An action that can be taken at a place
enum PlaceAction: Identifiable {
    
    case look
    case shop(ShopID)
    case talk(ActionPossibilities)

    /// Time to perform the action in seconds
    var time: Int64 {
        switch self {
        case .look:
            return 10
        case .shop:
            return 0
        case .talk:
            return 60
        }
    }
    
    var text: String {
        switch self {
        case .look:
            return "Look"
        case .shop:
            return "Shop"
        case .talk:
            return "Talk"
        }
    }
    
    var icon: Image {
        switch self {
        case .look:
            Image(systemName: "eye.fill")
        case .shop:
            Image(systemName: "dollarsign.bank.building.fill")
        case .talk:
            Image(systemName: "captions.bubble")
        }
    }
    
    var id: String {
        switch self {
        case .shop(let shopID):
            return "shop-\(shopID)"
        default:
            return text
        }
    }
    
}
