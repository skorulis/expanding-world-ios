//Created by Alexander Skorulis on 15/2/2025.

import Core
import Foundation
import KnitMacros
import Knit

@Observable final class ShopViewModel {
    
    private let shopStore: ShopStore
    private let playerStore: PlayerStore
    private let knowledgeStore: KnowledgeStore
    var shop: Shop
    var selectedItem: Item?
    
    @Resolvable<Resolver>
    init(
        @Argument shopID: ShopID,
        shopStore: ShopStore,
        playerStore: PlayerStore,
        knowledgeStore: KnowledgeStore
    ) {
        self.shopStore = shopStore
        self.shop = shopStore.getShop(id: shopID)
        self.playerStore = playerStore
        self.knowledgeStore = knowledgeStore
    }
}

extension ShopViewModel {
    @MainActor func buy(item: Item.Instance) {
        self.selectedItem = nil
        shop.inventory.subtract(item)
        shopStore.update(shop: shop)
        playerStore.player.inventory.add(item)
        playerStore.player.money -= item.baseCost
        knowledgeStore.learn(game: .inventory)
    }
}
