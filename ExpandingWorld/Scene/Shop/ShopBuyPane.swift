//Created by Alexander Skorulis on 15/2/2025.

import Core
import SwiftUI

// MARK: - Memory footprint

struct ShopBuyPane {
    let item: Item
    let maxQuantity: Int
    let onResult: @MainActor (Result) -> Void
    @State private var quantity: Int = 1
    
    enum Result {
        case cancel
        case confirm(quantity: Int)
    }
}

// MARK: - Rendering

extension ShopBuyPane: View {
    
    private var quantityProxy: Binding<Double> {
        return .init {
            Double(quantity)
        } set: { newValue in
            quantity = Int(newValue)
        }
    }
    
    private var totalCost: Int64 {
        return Int64(quantity) * item.basePrice
    }
    
    var body: some View {
        VStack {
            details
            Slider(value: quantityProxy, in: 1.0...Double(maxQuantity), step: 1.0)
            MoneyView(amount: totalCost)
            buttons
        }
    }
    
    private var buttons: some View {
        HStack {
            Button(action: { onResult(.cancel) }) {
                Text("Cancel")
            }
            Button(action: { onResult(.confirm(quantity: quantity)) }) {
                Text("Confirm")
            }
        }
    }
    
    private var details: some View {
        VStack(spacing: 0) {
            ItemView(
                item: .init(type: item, amount: maxQuantity),
                style: .cost,
                selected: false
            )
            Text(item.name)
            Text("\(quantity)/\(maxQuantity)")
        }
    }
}

// MARK: - Previews

#Preview {
    @Previewable @State var quantity = 1
    let item = Item.stew
    ShopBuyPane(item: item, maxQuantity: 50) { _ in }
        .border(Color.red)
        .padding()
}

