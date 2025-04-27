//Created by Alexander Skorulis on 16/2/2025.

import Core
import Foundation
import Knit
import KnitMacros

@Observable final class PlayerInventoryViewModel {
    
    let playerStore: PlayerStore
    let timeStore: TimeStore
    
    var selectedItem: Item.Instance?
    
    @Resolvable<Resolver>
    init(playerStore: PlayerStore, timeStore: TimeStore) {
        self.playerStore = playerStore
        self.timeStore = timeStore
    }
    
    func onAction(item: Item.Instance, action: Item.Action) {
        playerStore.player.inventory.subtract(.init(type: item.type, amount: 1))
        timeStore.advance(seconds: item.type.consumptionTime)
        if playerStore.player.inventory.count(item.type) == 0 {
            selectedItem = nil
        }
        for effect in item.type.consumptionEffects {
            switch effect {
            case let .addStatus(status, amount):
                playerStore.player.statuses.add(status: status, amount: amount)
            }
        }
    }
}
