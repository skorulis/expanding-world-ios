//  Created by Alexander Skorulis on 15/5/2025.

import Foundation
import SwiftUI

@Observable final class BattlerShopViewModel {
    
    var shop: BattlerShop
    
    var selectedIndex: Int?
    
    init(shop: BattlerShop) {
        self.shop = shop
    }
    
}
