//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ShopView {
    let shop: Shop
    let onSelect: (Item) -> Void
}

// MARK: - Rendering

extension ShopView: View {
    
    var body: some View {
        HexagonGrid(hexSize: ItemView.size / 2) {
            ForEach(shop.items) { item in
                Button(action: {}) {
                    ItemView(item: item, style: .cost)
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let shop = Shop(
        spec: ShopLibrary.pinkyTavern
    )
    ShopView(shop: shop, onSelect: { _ in })
}

