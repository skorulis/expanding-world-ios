//Created by Alexander Skorulis on 15/2/2025.

import SwiftUI

struct HexagonGrid: Layout {
    
    func makeCache(subviews: Subviews) -> Cache {
        let columns = subviews.count
        let rows = 1
        return .init(columns: columns, rows: rows)
    }
    
    let hexSize: CGFloat
    let hexHeight: CGFloat
    
    init(hexSize: CGFloat) {
        self.hexSize = hexSize
        hexHeight = sqrt(3) * hexSize
    }
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) -> CGSize {
        if subviews.isEmpty { return .zero }
        if let width = proposal.width, width > 0, width != .infinity {
            cache.columns = max(min(Int(width / hexSize / 2), subviews.count), 1)
            cache.rows = (subviews.count + cache.columns - 1) / cache.columns
        }
        let hexWidth = hexSize * 2
        let spacingX = hexWidth * 0.75
        let spacingY = hexHeight
        let hasExtraBottom = subviews.count % cache.columns != 1 && subviews.count > 1
        let bottomSpace = hasExtraBottom ? hexSize : hexSize / 2
        
        return CGSize(
            width: CGFloat(cache.columns) * spacingX + hexSize / 2,
            height: CGFloat(cache.rows) * spacingY + bottomSpace
        )
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) {
        let hexWidth = hexSize * 2
        let spacingX = hexWidth * 0.75
        let spacingY = hexHeight
        
        for (index, subview) in subviews.enumerated() {
            let row = index / cache.columns
            let col = index % cache.columns
            let xOffset = CGFloat(col) * spacingX - hexSize
            let yOffset = CGFloat(row) * spacingY + (col % 2 == 1 ? spacingY / 2 : 0) - hexSize
            
            subview.place(
                at: CGPoint(
                    x: bounds.origin.x + xOffset + hexSize,
                    y: bounds.origin.y + yOffset + hexSize
                ),
                proposal: .unspecified
            )
        }
    }
}

extension HexagonGrid {
    struct Cache {
        var columns: Int
        var rows: Int
    }
}

#Preview {
    HexagonGrid(hexSize: 40) {
        ForEach(0..<1, id: \.self) { index in
            ZStack {
                Text("\(index)")
                HexagonShape()
                    .stroke(Color.blue)
            }
            .frame(width: 80, height: 80)
        }
    }
    .border(Color.red)
    .padding()
    
}
