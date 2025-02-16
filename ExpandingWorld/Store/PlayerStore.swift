//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import Knit
import KnitMacros

@Observable final class PlayerStore {
    
    let knowledgeStore: KnowledgeStore
    var player: Player {
        didSet {
            if player.statuses.value(.intoxication) >= 5 {
                knowledgeStore.learn(game: .intoxication)
            }
            if player.statuses.value(.satiation) <= 5 {
                knowledgeStore.learn(game: .satiation)
            }
        }
    }
    
    @Resolvable<Resolver>
    init(knowledgeStore: KnowledgeStore) {
        self.player = .default
        self.knowledgeStore = knowledgeStore
    }
    
}
