//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import SwiftUI

/// An action that can be taken at a place
enum PlaceAction: Identifiable {
    
    case look

    /// Time to perform the action in seconds
    var time: Int64 {
        switch self {
        case .look:
            return 10
        }
    }
    
    var text: String {
        switch self {
        case .look:
            "Look around"
        }
    }
    
    var icon: Image {
        switch self {
        case .look:
            Image(systemName: "eye.fill")
        }
    }
    
    var id: Self {
        self
    }
    
}
