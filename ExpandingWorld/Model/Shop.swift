//Created by Alexander Skorulis on 15/2/2025.

import Foundation

struct Shop {
    
    let spec: ShopSpec
    var inventory: Inventory
    
    init(spec: ShopSpec) {
        self.spec = spec
        self.inventory = .init(items: spec.startingItems)
    }
}

struct ShopSpec {
    
    let id: ShopID
    let startingItems: [Item.Instance]
}
