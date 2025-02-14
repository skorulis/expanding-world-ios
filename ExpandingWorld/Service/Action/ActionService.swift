//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import Knit
import KnitMacros

final class ActionService {
    
    private let timeStore: TimeStore
    private let knowledgeStore: KnowledgeStore
    
    @Resolvable<Resolver>
    init(timeStore: TimeStore, knowledgeStore: KnowledgeStore) {
        self.timeStore = timeStore
        self.knowledgeStore = knowledgeStore
    }
    
    func actions(place: Place) -> [PlaceAction] {
        return place.spec.actions
    }
    
    func perform(action: PlaceAction, place: Place) {
        timeStore.advance(seconds: action.time)
        switch action {
        case .look:
            for feature in place.spec.features {
                knowledgeStore.placeFeatures.insert(feature.id)
            }
        }
        
    }
}
