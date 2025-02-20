//Created by Alexander Skorulis on 14/2/2025.

import ASKCore
import Foundation
import KnitMacros
import Knit

final class KnowledgeStore: ObservableObject {
    
    @Published var knowledge: Knowledge {
        didSet {
            try? keyValueStore.set(knowledge)
        }
    }
    
    private let alertService: AlertService
    private let keyValueStore: PKeyValueStore
    
    @Resolvable<Resolver>
    init(alertService: AlertService, keyValueStore: PKeyValueStore) {
        self.knowledge = keyValueStore.dataStorable()
        self.alertService = alertService
        self.keyValueStore = keyValueStore
    }
    
    func learn(placeFeature: PlaceFeatureID) {
        knowledge.placeFeatures.insert(placeFeature)
    }
    
    func learn(game: GameFeature) {
        if !knowledge.gameFeatures.contains(game) {
            knowledge.gameFeatures.insert(game)
            alertService.post(message: game.discoveryText)
        }
    }
    
    func contains(any: [GameFeature]) -> Bool {
        return any.contains(where: { knowledge.gameFeatures.contains($0) })
    }
    
}

extension KnowledgeStore: ResettableService {
    func resetData() {
        knowledge = .defaultValue
    }
}
