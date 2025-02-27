//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import SwiftUI

/// An action that can be taken at a place
enum PlaceAction: Identifiable {
    
    case look
    case shop(ShopID)
    case talk(ActionPossibilities)
    case work(Int64, ActionPossibilities)

    /// Time to perform the action in seconds
    var time: Int64 {
        switch self {
        case .look:
            return 10
        case .shop:
            return 0
        case .talk:
            return 60
        case let .work(duration, _):
            return duration
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
        case let .work(duration, _):
            return "Work \(TimeFormatter.default.format(time: duration))"
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
        case .work:
            Image(systemName: "figure.run.circle")
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
