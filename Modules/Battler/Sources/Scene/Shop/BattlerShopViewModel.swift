//  Created by Alexander Skorulis on 15/5/2025.

import Foundation
import ASKCoordinator
import SwiftUI

@Observable final class BattlerShopViewModel: CoordinatorViewModel {
    
    private let onFinish: (BattlerPlayer) -> Void
    var shop: BattlerShop
    var player: BattlerPlayer
    var selectedIndex: Int?
    var coordinator: Coordinator?
    
    init(shop: BattlerShop, player: BattlerPlayer, onFinish: @escaping (BattlerPlayer) -> Void) {
        self.shop = shop
        self.player = player
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
    
    func finish() {
        coordinator?.dismiss()
    }
}
