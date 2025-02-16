//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ShopView {
    
    @State var viewModel: ShopViewModel
}

// MARK: - Rendering

extension ShopView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            items
            Spacer()
            maybeBuyPane
        }
    }
    
    @ViewBuilder
    private var maybeBuyPane: some View {
        if let selected = viewModel.selectedItem {
            ShopBuyPane(
                item: selected,
                maxQuantity: 20
            ) { result in
                    switch result {
                    case let .confirm(quantity):
                        viewModel.buy(item: selected, quantity: quantity)
                    case .cancel:
                        viewModel.selectedItem = nil
                    }
                }
            Text("Test")
        }
    }
    
    private var items: some View {
        HexagonGrid(hexSize: ItemView.size / 2) {
            ForEach(viewModel.shop.items) { item in
                Button(action: { viewModel.selectedItem = item.type }) {
                    ItemView(
                        item: item,
                        style: .cost,
                        selected: viewModel.selectedItem == item.type
                    )
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    let viewModel = assembler.resolver.shopViewModel(shopID: .pinkyTavern)
    ShopView(viewModel: viewModel)
}

