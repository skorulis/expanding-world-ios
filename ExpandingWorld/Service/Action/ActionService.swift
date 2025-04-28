//Created by Alexander Skorulis on 14/2/2025.

import Core
import GameSystem
import Foundation
import Knit
import KnitMacros

final class ActionService {
    
    private let evaluator: Evaluator
    private let timeStore: TimeStore
    private let knowledgeStore: KnowledgeStore
    private let alertService: AlertService
    
    @Resolvable<Resolver>
    init(timeStore: TimeStore, knowledgeStore: KnowledgeStore, alertService: AlertService, evaluator: Evaluator) {
        self.timeStore = timeStore
        self.knowledgeStore = knowledgeStore
        self.alertService = alertService
        self.evaluator = evaluator
    }
    
    func actions(place: Place) -> [PlaceAction] {
        return place.spec.actions
    }
    
    @MainActor func perform(action: PlaceAction, place: Place) {
        timeStore.advance(seconds: action.time)
        switch action {
        case .look:
            for feature in place.spec.features {
                knowledgeStore.learn(placeFeature: feature.id)
            }
            alertService.post(message: place.spec.description)
        case .shop:
            knowledgeStore.learn(game: .money)
        case let .talk(possibilities):
            complete(possibilities: possibilities)
        case let .work(_, possibilities):
            complete(possibilities: possibilities)
        }
    }
    
    @MainActor func perform(action: PlaceAction, place: Place, feature: Place.Feature) {
        timeStore.advance(seconds: action.time)
        switch action {
        case .look:
            alertService.post(message: feature.description)
        case .shop:
            knowledgeStore.learn(game: .money)
        case let .talk(possibilities):
            complete(possibilities: possibilities)
        case let .work(_, possibilities):
            complete(possibilities: possibilities)
        }
    }
    
    @MainActor func complete(possibilities: ActionPossibilities) {
        let result = resolve(possibilities: possibilities)
        enact(outcomes: result)
    }
    
    /// Find the outcomes from a set of possibilities
    func resolve(possibilities: ActionPossibilities) -> [ActionOutcome] {
        for conditional in possibilities.conditionals {
            if evaluator.evaluate(conditional.condition) > 0 {
                return conditional.outcomes
            }
        }
        return possibilities.fallback
    }
    
    @MainActor func enact(outcomes: [ActionOutcome]) {
        outcomes.forEach { enact(outcome: $0) }
    }
    
    @MainActor func enact(outcome: ActionOutcome) {
        switch outcome {
        case let .alert(message):
            alertService.post(message: message)
        case let .time(seconds):
            timeStore.advance(seconds: seconds)
        }
    }
}
