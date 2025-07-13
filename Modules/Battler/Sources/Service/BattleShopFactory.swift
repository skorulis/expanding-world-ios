//  Created by Alexander Skorulis on 17/5/2025.

import Core
import Foundation

struct BattleShopFactory {
    
    func makeShop() -> BattlerShop {
        return .init(spec: ShopSpec.allCases.randomElement()!)
    }
}
