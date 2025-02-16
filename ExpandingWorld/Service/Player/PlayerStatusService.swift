//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import KnitMacros
import Knit

final class PlayerStatusService {
    
    let playerStore: PlayerStore
    let timeStore: TimeStore
    let knowledgeStore: KnowledgeStore
    
    @Resolvable<Resolver>
    init(playerStore: PlayerStore, timeStore: TimeStore, knowledgeStore: KnowledgeStore) {
        self.playerStore = playerStore
        self.timeStore = timeStore
        self.knowledgeStore = knowledgeStore
        timeStore.addObserver(self)
    }
}

extension PlayerStatusService: TimeStore.Observer {
    func timeAdvanced(seconds: Int64) {
        var player = playerStore.player
        for status in Player.Status.allCases {
            var value = player.statuses.value(status)
            let change = min(abs(value), Float(seconds) * status.normalisationRate)
            if value > 0 {
                value -= change
            } else if value < 0 {
                // Not currently sure if there's a way to go negative here
                value += change
            }
            player.statuses.values[status] = value
        }
        playerStore.player = player
    }
}
