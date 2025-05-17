//  Created by Alexander Skorulis on 15/5/2025.

import Core
import SwiftUI

// MARK: - Memory footprint

struct ShopItemCard {
    let item: Item.Instance
    @Binding var isSelected: Bool
}

// MARK: - Rendering

extension ShopItemCard: View {
    
    var body: some View {
        VStack(spacing: 8) {
            // Item icon/image
            item.type.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(10)
                .background(
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1))
                )
            
            // Item name
            Text(item.type.name)
                .font(.headline)
            
            // Item amount
            if item.amount > 1 {
                Text("x\(item.amount)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Price
            
            Text("\(item.type.basePrice) coins") // Replace with actual price
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

// MARK: - Previews

#Preview {
    @Previewable @State var selected: Bool = false
    ShopItemCard(
        item: .init(type: .stew, amount: 1),
        isSelected: $selected
    )
}
