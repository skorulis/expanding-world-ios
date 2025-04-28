//Created by Alexander Skorulis on 15/2/2025.

import ASKCore
import Foundation
import GameSystem
import Knit
import KnitMacros

final class ShopStore: ObservableObject {
    @Published private(set) var shops: Shops {
        didSet {
            try! keyValueStore.set(shops)
        }
    }
    
    private let keyValueStore: PKeyValueStore
    
    @Resolvable<Resolver>
    init(keyValueStore: PKeyValueStore) {
        self.keyValueStore = keyValueStore
        shops = keyValueStore.dataStorable()
    }
    
    func getShop(id: ShopID) -> Shop {
        if let existingShop = shops.shops[id] {
            return existingShop
        }
        let spec = ShopLibrary.specsByID[id]!
        let shop = Shop(spec: spec)
        shops.shops[id] = shop
        return shop
    }
    
    func update(shop: Shop) {
        shops.shops[shop.spec.id] = shop
    }
}

struct Shops: Codable, DataStorable {
    static var storageKey: DataStoreKey { .shops }
    
    static var defaultValue: Shops { .init(shops: [:]) }
    
    var shops: [ShopID: Shop]
}

extension ShopStore: ResettableService {
    func resetData() {
        shops = .defaultValue
    }
}
