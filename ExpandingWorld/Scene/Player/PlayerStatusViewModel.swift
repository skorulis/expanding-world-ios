//Created by Alexander Skorulis on 16/2/2025.

import Core
import Foundation
import Knit
import KnitMacros

@Observable final class PlayerStatusViewModel {
    
    let playerStore: PlayerStore
    let knowledgeStore: KnowledgeStore
    
    @Resolvable<BaseResolver>
    init(playerStore: PlayerStore, knowledgeStore: KnowledgeStore) {
        self.playerStore = playerStore
        self.knowledgeStore = knowledgeStore
    }
}

extension PlayerStatusViewModel {
    func value(_ status: Player.Status) -> Float {
        return playerStore.player.statuses.value(status)
    }
}
