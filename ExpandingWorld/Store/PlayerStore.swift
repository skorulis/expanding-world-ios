//Created by Alexander Skorulis on 16/2/2025.

import ASKCore
import Foundation
import Knit
import KnitMacros

@Observable final class PlayerStore {
    
    private let keyValueStore: PKeyValueStore
    private let knowledgeStore: KnowledgeStore
    var player: Player {
        didSet {
            if player.statuses.value(.intoxication) >= 5 {
                knowledgeStore.learn(game: .intoxication)
            }
            if player.statuses.value(.satiation) <= 5 {
                knowledgeStore.learn(game: .satiation)
            }
            try? keyValueStore.set(player)
        }
    }
    
    @Resolvable<Resolver>
    init(keyValueStore: PKeyValueStore, knowledgeStore: KnowledgeStore) {
        self.keyValueStore = keyValueStore
        self.knowledgeStore = knowledgeStore
        self.player = keyValueStore.dataStorable()
    }
    
}

extension PlayerStore: ResettableService {
    func resetData() {
        player = .defaultValue
    }
}
