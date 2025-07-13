//  Created by Alexander Skorulis on 16/5/2025.

import Core
import Foundation

public struct BattlerShop: Sendable {
    let spec: ShopSpec
    
    var items: [Item.Instance]
    var buffs: [BuffItem]
    
    init(spec: ShopSpec) {
        self.spec = spec
        self.buffs = spec.possibleBuffs.map { buff in
            BuffItem(buff: buff.buff, cost: buff.cost, count: 1)
        }
        self.items = spec.possibleItems.map { item in
            Item.Instance(type: item.item, amount: item.count)
        }
    }
}

extension BattlerShop {
    struct BuffItem: Identifiable {
        let id: UUID = .init()
        let buff: Buff
        let cost: Int
        var count: Int
    }
}
