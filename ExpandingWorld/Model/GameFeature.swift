//Created by Alexander Skorulis on 15/2/2025.

import Foundation

enum GameFeature {
    case money
    case time
    
    var discoveryText: String {
        switch self {
        case .money:
            return "You reach into your pocket to see what money you have to pay with"
        case .time:
            return ""
        }
    }
}
