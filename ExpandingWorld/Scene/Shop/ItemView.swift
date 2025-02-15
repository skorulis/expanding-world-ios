//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ItemView {
    let item: Item.Instance
    let style: Style
    
    static let size: CGFloat = 72
    
    enum Style {
        case cost
        case quantity
    }
}

// MARK: - Rendering

extension ItemView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            item.type.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.white)
                .frame(width: 32, height: 32)
                .shadow(color: .black, radius: 3)
            text
        }
        .frame(width: Self.size, height: Self.size)
        .background(
            HexagonShape()
                .fill(.linearGradient(
                    Gradient(colors: [item.type.rarity.color, item.type.category.color]),
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                ))
        )
    }
    
    @ViewBuilder
    private var text: some View {
        switch style {
        case .cost:
            MoneyView(amount: item.type.basePrice)
        case .quantity:
            Text("\(item.amount)")
                .foregroundStyle(Color.white)
                .shadow(color: .black, radius: 3)
        }
    }
}

// MARK: - Previews

#Preview {
    VStack(spacing: 0) {
        ItemView(
            item: .init(type: .grog, amount: 10),
            style: .cost
        )
        
        ItemView(
            item: .init(type: .grog, amount: 10),
            style: .quantity
        )
    }
    
}

