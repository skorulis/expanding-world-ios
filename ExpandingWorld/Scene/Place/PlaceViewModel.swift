//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import Knit
import KnitMacros

@MainActor @Observable final class PlaceViewModel {
    
    let place: Place
    private let knowledgeStore: KnowledgeStore
    private let actionService: ActionService
    private(set) var visibleFeatures: [Place.Feature]
    
    var shopID: ShopID?
    
    @Resolvable<Resolver>
    init(@Argument place: Place, actionService: ActionService, knowledgeStore: KnowledgeStore) {
        self.place = place
        self.actionService = actionService
        self.knowledgeStore = knowledgeStore
        self.visibleFeatures = place.spec.features.filter { knowledgeStore.knowledge.placeFeatures.contains($0.id) }
    }
    
    var actions: [PlaceAction] {
        actionService.actions(place: place)
    }
    
    func perform(action: PlaceAction) {
        actionService.perform(action: action, place: place)
        self.visibleFeatures = place.spec.features.filter { knowledgeStore.knowledge.placeFeatures.contains($0.id) }
    }
    
    func perform(action: PlaceAction, feature: Place.Feature) {
        if case let .shop(shopID) = action {
            self.shopID = shopID
        }
        actionService.perform(action: action, place: place, feature: feature)
    }
}
