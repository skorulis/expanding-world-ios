//  Created by Alexander Skorulis on 15/5/2025.

import DesignSystem
import Foundation
import SwiftUI
import Core

// MARK: - Memory footprint

@MainActor
struct GeneralShopView {
    @State var viewModel: GeneralShopViewModel
}

// MARK: - Rendering

extension GeneralShopView: View {
    
    var body: some View {
        VStack(spacing: 16) {
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
            
            buyButton
        }
    }
    
    private var buffList: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.shop.buffs) { buff in
                    Button(action: { }) {
                        TempleBuffView(item: buff)
                    }
                }
            }
        }
    }
    
    private var buyButton: some View {
        Button(action: {
            viewModel.buy()
        }) {
            Text(buyButtonTitle)
        }
        .buttonStyle(RectangleButtonStyle())
        .padding(.horizontal)
        .disabled(!viewModel.canBuy)
    }
    
    private var buyButtonTitle: String {
        guard let selectedIndex = viewModel.selectedIndex else {
            return "Buy"
        }
        let item = viewModel.shop.items[selectedIndex]
        return "Buy \(item.type.name) for \(item.type.basePrice) coins"
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

#Preview("General") {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let shop = BattlerShop(spec: .generalStore)
    GeneralShopView(
        viewModel: resolver.generalShopViewModel(
            shop: shop
        )
    )
}

#Preview("Temple") {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let shop = BattlerShop(spec: .lightTemple)
    GeneralShopView(
        viewModel: resolver.generalShopViewModel(
            shop: shop
        )
    )
}
