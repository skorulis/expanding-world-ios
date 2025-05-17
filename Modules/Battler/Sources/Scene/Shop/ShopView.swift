//  Created by Alexander Skorulis on 15/5/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ShopView {
    @State var viewModel: BattlerShopViewModel
}

// MARK: - Rendering

extension ShopView: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.shop.items) { item in
                    ShopItemCard(item: item)
                }
            }
            .padding()
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let shop = BattlerShop(items: [
        .init(type: .stew, amount: 1),
        .init(type: .stew, amount: 1),
    ])
    ShopView(viewModel: resolver.battlerShopViewModel(shop: shop))
}

