//Created by Alexander Skorulis on 14/2/2025.

import Combine
import Foundation
import Knit
import KnitMacros

@MainActor @Observable final class PlaceViewModel {
    
    let place: Place
    private let knowledgeStore: KnowledgeStore
    private let actionService: ActionService
    private let playerStore: PlayerStore
    private(set) var visibleFeatures: [Place.Feature] = []
    private var cancellables: Set<AnyCancellable> = []
    
    var shopID: ShopID?
    
    @Resolvable<Resolver>
    init(@Argument place: Place, actionService: ActionService, knowledgeStore: KnowledgeStore, playerStore: PlayerStore) {
        self.place = place
        self.actionService = actionService
        self.knowledgeStore = knowledgeStore
        self.playerStore = playerStore
        
        knowledgeStore.$knowledge.sink { knowledge in
            self.visibleFeatures = place.spec.features.filter { knowledge.placeFeatures.contains($0.id) }
        }
        .store(in: &cancellables)
    }
    
    var actions: [PlaceAction] {
        actionService.actions(place: place)
    }
    
    var transit: [PlaceTransit] {
        place.spec.transit
    }
    
    func perform(action: PlaceAction) {
        actionService.perform(action: action, place: place)
    }
    
    func perform(action: PlaceAction, feature: Place.Feature) {
        if case let .shop(shopID) = action {
            self.shopID = shopID
        }
        actionService.perform(action: action, place: place, feature: feature)
    }
    
    func changeLocation(id: PlaceID) {
        playerStore.player.location = id
        switch id {
        case .wharfRoad:
            knowledgeStore.learn(game: .time)
        default:
            break
        }
    }
}
