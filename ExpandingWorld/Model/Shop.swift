//Created by Alexander Skorulis on 15/2/2025.

import Foundation

struct Shop {
    
    let spec: ShopSpec
    var items: [Item.Instance]
    
    init(spec: ShopSpec) {
        self.spec = spec
        self.items = spec.startingItems
    }
}

struct ShopSpec {
    
    let id: ShopID
    let startingItems: [Item.Instance]
}
