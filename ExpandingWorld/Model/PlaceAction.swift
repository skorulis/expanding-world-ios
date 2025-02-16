//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import SwiftUI

/// An action that can be taken at a place
enum PlaceAction: Identifiable {
    
    case look
    case shop(ShopID)

    /// Time to perform the action in seconds
    var time: Int64 {
        switch self {
        case .look:
            return 10
        case .shop:
            return 0
        }
    }
    
    var text: String {
        switch self {
        case .look:
            return "Look"
        case .shop:
            return "Shop"
        }
    }
    
    var icon: Image {
        switch self {
        case .look:
            Image(systemName: "eye.fill")
        case .shop:
            Image(systemName: "dollarsign.bank.building.fill")
        }
    }
    
    var id: String {
        switch self {
        case .look:
            return "look"
        case .shop(let shopID):
            return "shop-\(shopID)"
        }
    }
    
}
