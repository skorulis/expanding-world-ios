//Created by Alexander Skorulis on 15/2/2025.

import Combine
import Core
import Foundation
import GameSystem
import Knit
import KnitMacros

final class GameService {
    
    private let alertService: AlertService
    private let knowledgeStore: KnowledgeStore
    private let playerStore: PlayerStore
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Resolvable<Resolver>
    init(alertService: AlertService, knowledgeStore: KnowledgeStore, playerStore: PlayerStore) {
        self.alertService = alertService
        self.knowledgeStore = knowledgeStore
        self.playerStore = playerStore
        
        playerStore.playerSubject.sink { [unowned self] player in
            if player.statuses.value(.health) <= 0 {
                // self.playerDied()
            }
        }
        .store(in: &cancellables)
    }
    
    @MainActor func setup() {
        if knowledgeStore.knowledge.gameFeatures.count == 0 {
            startNewGame()
        }
    }
    
    @MainActor func startNewGame() {
        // alertService.post(message: "You wake up in a dimly lit room sitting at a table. It is not a place you recognise.")
    }
    
    @MainActor func playerDied() {
        playerStore.player.playerDied()
        if playerStore.player.deaths == 1 {
            alertService.post(message: "What just happened? How did I end up here again.")
        }
    }
    
}
