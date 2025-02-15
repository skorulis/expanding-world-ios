//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import Knit
import KnitMacros

final class ActionService {
    
    private let timeStore: TimeStore
    private let knowledgeStore: KnowledgeStore
    private let alertService: AlertService
    
    @Resolvable<Resolver>
    init(timeStore: TimeStore, knowledgeStore: KnowledgeStore, alertService: AlertService) {
        self.timeStore = timeStore
        self.knowledgeStore = knowledgeStore
        self.alertService = alertService
    }
    
    func actions(place: Place) -> [PlaceAction] {
        return place.spec.actions
    }
    
    func perform(action: PlaceAction, place: Place) {
        timeStore.advance(seconds: action.time)
        switch action {
        case .look:
            for feature in place.spec.features {
                knowledgeStore.learn(placeFeature: feature.id)
            }
            alertService.post(message: place.spec.description)
        case .shop:
            knowledgeStore.learn(game: .money)
            break
        }
    }
    
    func perform(action: PlaceAction, place: Place, feature: Place.Feature) {
        timeStore.advance(seconds: action.time)
        switch action {
        case .look:
            alertService.post(message: feature.description)
        case .shop:
            knowledgeStore.learn(game: .money)
            break
        }
    }
}
