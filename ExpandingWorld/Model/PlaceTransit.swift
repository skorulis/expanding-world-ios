//Created by Alexander Skorulis on 18/2/2025.

import Foundation

struct PlaceTransit: Identifiable {
    let to: PlaceID
    let text: String
    
    var id: PlaceID { to }
}
