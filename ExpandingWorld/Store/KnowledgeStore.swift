//Created by Alexander Skorulis on 14/2/2025.

import Foundation

final class KnowledgeStore: ObservableObject {
    
    @Published var placeFeatures: Set<PlaceFeatureID> = []
    @Published var gameFeatures: Set<GameFeature> = []
}
