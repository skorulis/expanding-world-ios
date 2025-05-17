//  Created by Alexander Skorulis on 15/5/2025.

import Core
import SwiftUI

// MARK: - Memory footprint

struct ShopItemCard {
    let item: Item.Instance
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
            
            Text("100 coins") // Replace with actual price
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

// MARK: - Previews

#Preview {
    ShopItemCard(item: .init(type: .stew, amount: 1))
}
