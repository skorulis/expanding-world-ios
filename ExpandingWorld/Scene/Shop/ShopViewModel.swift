//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import KnitMacros
import Knit

@Observable final class ShopViewModel {
    
    private let shopStore: ShopStore
    var shop: Shop
    var selectedItem: Item?
    
    @Resolvable<Resolver>
    init(@Argument shopID: ShopID, shopStore: ShopStore) {
        self.shopStore = shopStore
        self.shop = shopStore.getShop(id: shopID)
    }
}

extension ShopViewModel {
    func buy(item: Item, quantity: Int) {
        self.selectedItem = nil
    }
}
