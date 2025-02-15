//Created by Alexander Skorulis on 15/2/2025.

import Foundation

final class ShopLibrary {
    
    static var pinkyTavern: ShopSpec {
        ShopSpec(
            id: .pinkyTavern,
            startingItems: [
                .init(type: .grog, amount: 100),
                .init(type: .stew, amount: 10),
            ]
        )
    }
}

enum ShopID {
    case pinkyTavern
}
