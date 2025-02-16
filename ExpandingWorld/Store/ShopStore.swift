//Created by Alexander Skorulis on 15/2/2025.

import Foundation

final class ShopStore: ObservableObject {
    @Published private(set) var shops: [ShopID: Shop] = [:]
    
    func getShop(id: ShopID) -> Shop {
        if let existingShop = shops[id] {
            return existingShop
        }
        let spec = ShopLibrary.specsByID[id]!
        let shop = Shop(spec: spec)
        shops[id] = shop
        return shop
    }
    
    func update(shop: Shop) {
        shops[shop.spec.id] = shop
    }
}
