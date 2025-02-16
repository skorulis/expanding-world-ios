//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import Knit
import KnitMacros

@Observable final class PlayerStatusViewModel {
    
    let playerStore: PlayerStore
    let knowledgeStore: KnowledgeStore
    
    @Resolvable<Resolver>
    init(playerStore: PlayerStore, knowledgeStore: KnowledgeStore) {
        self.playerStore = playerStore
        self.knowledgeStore = knowledgeStore
    }
}
