//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import KnitMacros
import Knit

final class KnowledgeStore: ObservableObject {
    
    @Published private(set) var placeFeatures: Set<PlaceFeatureID> = []
    @Published private(set) var gameFeatures: Set<GameFeature> = []
    
    private let alertService: AlertService
    
    @Resolvable<Resolver>
    init(alertService: AlertService) {
        self.alertService = alertService
    }
    
    func learn(placeFeature: PlaceFeatureID) {
        placeFeatures.insert(placeFeature)
    }
    
    func learn(game: GameFeature) {
        if !gameFeatures.contains(game) {
            gameFeatures.insert(game)
            alertService.post(message: game.discoveryText)
        }
    }
}
