//Created by Alexander Skorulis on 17/2/2025.

import Core
import Foundation

public struct Knowledge: Codable {
    public var placeFeatures: Set<PlaceFeatureID> = []
    public var gameFeatures: Set<GameFeature> = []
    
    public init() {
        
    }
}
