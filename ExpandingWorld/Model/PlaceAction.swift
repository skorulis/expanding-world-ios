//Created by Alexander Skorulis on 14/2/2025.

import Foundation

/// An action that can be taken at a place
enum PlaceAction {
    /// Take a look around
    case look
    
    var text: String {
        switch self {
        case .look:
            return "Look around"
        }
    }
    
    /// Time to perform the action in seconds
    var time: Int64 {
        switch self {
        case .look:
            return 10
        }
    }
    
}
