//  Created by Alexander Skorulis on 14/2/2025.

import Foundation

/// A place that you can visit
struct Place {
    let spec: PlaceSpec
}

/// Immutable data about a place
struct PlaceSpec {
    
    /// Unique ID
    let id: PlaceID
    
    /// The name of the place
    let name: String
    
    /// High level description of the place
    let description: String
    
    /// Actions that can be performed at this place
    let actions: [PlaceAction]
    
    /// The individual elements that make up this place
    let features: [Place.Feature]
}

extension Place {
    struct Feature: Identifiable {
        /// Unique feature ID
        let id: PlaceFeatureID
        
        /// Name of the feature
        let name: String
        
        let description: String
        
        let actions: [PlaceAction]
    }
}

enum PlaceFeatureID: Codable {
    // pinkyTavern
    case pinkyTavernBar
    case pinkyTavernTables
    case pinkyTavernExit
}

enum PlaceID {
    case pinkyTavern
}
