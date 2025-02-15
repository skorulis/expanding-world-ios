//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MoneyView {
    let amount: Int64
    
    var gold: Int64 { amount / 10000 }
    var silver: Int64 { (amount % 10000) / 100 }
    var copper: Int64 { amount % 100 }
}

// MARK: - Rendering

extension MoneyView: View {
    
    var body: some View {
        HStack(spacing: 4) {
            if gold > 0 {
                singlePart(amount: gold, color: .yellow)
            }
            if silver > 0 {
                singlePart(amount: silver, color: .gray)
            }
            if copper > 0 && gold <= 0 {
                singlePart(amount: copper, color: .orange)
            }
        }
        .padding(.horizontal, 4)
        .background(
            Capsule()
                .fill(Color.white)
        )
    }
    
    private func singlePart(amount: Int64, color: Color) -> some View {
        HStack(spacing: 0) {
            Text("\(amount)")
                .foregroundStyle(Color.black)
            Text("●")
                .font(.caption)
                .foregroundColor(color)
        }
    }
}

// MARK: - Previews

#Preview {
    VStack {
        MoneyView(amount: 10)
        MoneyView(amount: 100)
        MoneyView(amount: 110)
        MoneyView(amount: 500110)
        MoneyView(amount: 100000)
    }
    .background(Color.gray)
    
}

