    //  Created by Alexander Skorulis on 14/7/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct TempleBuffView {
    let item: Temple.BuffItem
}

// MARK: - Rendering

extension TempleBuffView: View {
    
    var body: some View {
        HStack(spacing: 0) {
            BuffView(buff: item.buff)
            cost
        }
        .border(Color.red)
    }
    
    private var cost: some View {
        VStack {
            Text("Cost: \(item.cost)")
            Text("x\(item.count)")
        }
        .padding(12)
    }
}

// MARK: - Previews

#Preview {
    TempleBuffView(
        item: .init(
            buff: .init(name: "Healing", effect: .healing(2), duration: .rounds(1)),
            cost: 10,
            count: 2
        )
    )
}

