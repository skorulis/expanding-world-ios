//  Created by Alexander Skorulis on 15/5/2025.

import Foundation
import ASKCoordinator
import SwiftUI

@Observable final class BattlerShopViewModel: CoordinatorViewModel {
    
    private let onFinish: (BattlerPlayer) -> Void
    private let playerStore: BattlerPlayerStore
    var shop: BattlerShop
    var player: BattlerPlayer {
        didSet {
            playerStore.player = player
        }
    }
    var selectedIndex: Int?
    var coordinator: Coordinator?
    
    init(shop: BattlerShop,
         playerStore: BattlerPlayerStore,
         onFinish: @escaping (BattlerPlayer) -> Void
    ) {
        self.shop = shop
        self.playerStore = playerStore
        self.player = playerStore.player
        self.onFinish = onFinish
    }
    
}

// MARK: - Logic

extension BattlerShopViewModel {
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
    
    func showInventory() {
        coordinator?.present(BattlerPath.equipment, style: .sheet)
    }
    
    func finish() {
        coordinator?.dismiss()
    }
}
