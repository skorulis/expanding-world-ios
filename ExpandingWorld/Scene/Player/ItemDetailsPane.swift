//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ItemDetailsPane {
    let item: Item.Instance
    let action: (Item.Action) -> Void
}

// MARK: - Rendering

extension ItemDetailsPane: View {
    
    var body: some View {
        VStack {
            HStack {
                ItemView(
                    item: item,
                    style: .cost,
                    selected: false
                )
                VStack(alignment: .leading) {
                    Text(item.type.name)
                    Text(item.type.description)
                }
            }
            buttons
        }
    }
    
    private var buttons: some View {
        HStack {
            if let actionText = item.type.consumableString {
                Button(action: { action(.consume) }) {
                    Text(actionText)
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ItemDetailsPane(
        item: .init(type: .grog, amount: 10),
        action: { _ in }
    )
}

