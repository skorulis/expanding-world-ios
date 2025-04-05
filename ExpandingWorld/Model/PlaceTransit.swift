//Created by Alexander Skorulis on 18/2/2025.

import Core
import Foundation

struct PlaceTransit: Identifiable {
    let from: (PlaceFeatureID)
    let to: (PlaceID, PlaceFeatureID)
    let text: String
    
    var id: String { "\(to.0)-\(to.1)" }
    
}
