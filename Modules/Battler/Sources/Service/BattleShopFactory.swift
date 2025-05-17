//  Created by Alexander Skorulis on 17/5/2025.

import Core
import Foundation

struct BattleShopFactory {
    
    func makeShop() -> BattlerShop {
        let items: [Item.Instance] = [
            .init(type: .leatherArmor, amount: 1),
            .init(type: .leatherArmor, amount: 1),
            .init(type: .leatherArmor, amount: 1),
        ]
        return .init(items: items)
    }
}
