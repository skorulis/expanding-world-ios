//Created by Alexander Skorulis on 17/2/2025.

import Foundation

struct Knowledge: Codable {
    var placeFeatures: Set<PlaceFeatureID> = []
    var gameFeatures: Set<GameFeature> = []
}

extension Knowledge: DataStorable {
    static var storageKey: DataStoreKey { .knowledge }
    static var defaultValue: Knowledge { .init() }
}
