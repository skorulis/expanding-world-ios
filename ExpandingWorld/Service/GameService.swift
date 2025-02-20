//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import Knit
import KnitMacros

final class GameService {
    
    private let alertService: AlertService
    private let knowledgeStore: KnowledgeStore
    
    @Resolvable<Resolver>
    init(alertService: AlertService, knowledgeStore: KnowledgeStore) {
        self.alertService = alertService
        self.knowledgeStore = knowledgeStore
    }
    
    func setup() {
        if knowledgeStore.knowledge.gameFeatures.count == 0 {
            startNewGame()
        }
    }
    
    func startNewGame() {
        alertService.post(message: "You wake up in a dimly lit room sitting at a table. It is not a place you recognise.")
    }
    
}
