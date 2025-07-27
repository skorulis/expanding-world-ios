//  Created by Alexander Skorulis on 19/5/2025.

import ASKCoordinator
import Core
import SwiftUI

@Observable final class PlayerEquipmentViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    private let playerStore: BattlerRunStore
    
    var player: BattlerPlayer {
        didSet {
            playerStore.player = player
        }
    }
    
    init(playerStore: BattlerRunStore) {
        self.playerStore = playerStore
        self.player = playerStore.player
    }
    
    func equippedItem(slot: EquipmentSlot) -> Item.Instance? {
        return player.inventory.equipped(slot)
    }
    
    func tryEquip(item: Item.Instance) {
        if let slot = item.type.slot {
            player.inventory.equip(item.type, slot)
        }
    }
    
    func unequip(slot: EquipmentSlot) {
        player.inventory.unequip(slot)
    }
}
