//  Created by Alexander Skorulis on 15/5/2025.

import Combine
import Foundation
import SwiftUI

@Observable final class GeneralShopViewModel {
    
    private let playerStore: BattlerRunStore
    var shop: BattlerShop
    var player: BattlerPlayer {
        didSet {
            playerStore.player = player
        }
    }
    var selectedIndex: Int?
    
    init(
        shop: BattlerShop,
        playerStore: BattlerRunStore
    ) {
        self.shop = shop
        self.playerStore = playerStore
        self.player = playerStore.player
    }
    
}

// MARK: - Logic

extension GeneralShopViewModel {
    var canBuy: Bool {
        guard let selectedIndex else { return  false }
        let price = shop.items[selectedIndex].baseCost
        return player.money >= price
    }
    
    func buy() {
        guard let selectedIndex else { return }
        self.selectedIndex = nil
        let item = shop.items[selectedIndex]
        shop.items.remove(at: selectedIndex)
        player.inventory.add(item)
        player.money -= item.baseCost
    }
    
}
