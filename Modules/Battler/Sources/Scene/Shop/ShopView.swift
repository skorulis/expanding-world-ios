//  Created by Alexander Skorulis on 15/5/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct ShopView {
    @State var viewModel: BattlerShopViewModel
}

// MARK: - Rendering

extension ShopView: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(viewModel.shop.items.indices), id: \.self) { index in
                    let item = viewModel.shop.items[index]
                    ShopItemCard(
                        item: item,
                        isSelected: binding(index)
                    )
                }
            }
            .padding()
        }
    }
    
    private func binding(_ index: Int) -> Binding<Bool> {
        return .init {
            viewModel.selectedIndex == index
        } set: { value in
            if value {
                viewModel.selectedIndex = index
            } else if viewModel.selectedIndex == index {
                viewModel.selectedIndex = nil
            }
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

