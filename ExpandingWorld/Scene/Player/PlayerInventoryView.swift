//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct PlayerInventoryView {
    @State var viewModel: PlayerInventoryViewModel
}

// MARK: - Rendering

extension PlayerInventoryView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            NavBar(title: "Inventory")
            items
            Spacer()
            maybeItemPane
        }
    }
    
    @ViewBuilder
    private var maybeItemPane: some View {
        if let selected = viewModel.selectedItem {
            ItemDetailsPane(
                item: selected,
                action: { viewModel.onAction(item: selected, action: $0) }
            )
        }
    }
    
    private var items: some View {
        HexagonGrid(hexSize: ItemView.size / 2) {
            ForEach(viewModel.playerStore.player.inventory.all) { item in
                Button(action: { viewModel.selectedItem = item }) {
                    ItemView(
                        item: item,
                        style: .quantity,
                        selected: viewModel.selectedItem?.type == item.type
                    )
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    let viewModel = assembler.resolver.playerInventoryViewModel()
    viewModel.playerStore.player.inventory.add(.init(type: .grog, amount: 20))
    return PlayerInventoryView(viewModel: viewModel)
}

