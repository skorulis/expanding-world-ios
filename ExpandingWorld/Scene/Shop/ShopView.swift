//Created by Alexander Skorulis on 15/2/2025.

import Core
import Foundation
import Hex
import SwiftUI

// MARK: - Memory footprint

struct ShopView {
    
    @State var viewModel: ShopViewModel
    @Environment(\.presentationMode) var presentationMode
}

// MARK: - Rendering

extension ShopView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            NavBar(
                leadingButton: .init(
                    icon: Image(systemName: "xmark.circle.fill"),
                    action: { presentationMode.wrappedValue.dismiss() }
                ),
                title: "Shop"
            )
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
                        viewModel.buy(item: .init(type: selected, amount: quantity))
                    case .cancel:
                        viewModel.selectedItem = nil
                    }
                }
        }
    }
    
    private var items: some View {
        HexagonGridLayout(hexSize: ItemView.size / 2) {
            ForEach(viewModel.shop.inventory.all) { item in
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

