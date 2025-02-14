//  Created by Alexander Skorulis on 14/2/2025.

import Foundation

/// A place that you can visit
struct Place {
    let spec: PlaceSpec
    
}

/// Immutable data about a place
struct PlaceSpec {
    
    let id: PlaceID
    
    /// The name of the place
    let name: String
    
    /// High level description of the place
    let description: String
    
    let actions: [PlaceAction]
    let features: [Place.Feature]
}

extension Place {
    struct Feature: Identifiable {
        let id: PlaceFeatureID
        let name: String
        let description: String
    }
}

enum PlaceFeatureID {
    // pinkyTavern
    case pinkyTavernBar
    case pinkyTavernTables
}

enum PlaceID {
    case pinkyTavern
}
