//  Created by Alexander Skorulis on 15/5/2025.

import Foundation
import SwiftUI
import Core

// MARK: - Memory footprint

@MainActor
struct ShopView {
    @State var viewModel: BattlerShopViewModel
}

// MARK: - Rendering

extension ShopView: View {
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Shop")
            Spacer()
            Text("\(viewModel.player.money) coins")
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
            
            finishButton
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
    
    private var finishButton: some View {
        Button(action: viewModel.finish) {
            Text("Finish")
        }
        .buttonStyle(RectangleButtonStyle())
        .padding(.horizontal)
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

#Preview {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let shop = BattlerShop(items: [
        .init(type: .leatherArmor, amount: 1),
        .init(type: .stew, amount: 1),
    ])
    ShopView(
        viewModel: resolver.battlerShopViewModel(
            shop: shop,
            player: .testPlayer(),
            onFinish: { _ in }
        )
    )
}

