//Created by Alexander Skorulis on 15/2/2025.

import Core
import SwiftUI

public struct HexagonGrid: Layout {
    
    public func makeCache(subviews: Subviews) -> Cache {
        let columns = subviews.count
        let rows = 1
        return .init(columns: columns, rows: rows)
    }
    
    let math: HexagonMath
    
    var hexSize: CGFloat
    var hexHeight: CGFloat { math.hexHeight }
    
    public init(hexSize: CGFloat) {
        self.hexSize = hexSize
        self.math = .init(width: hexSize * 2)
    }
    
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) -> CGSize {
        if subviews.isEmpty { return .zero }
        let (cols, rows) = math.fit(width: proposal.width, cellCount: subviews.count)
        cache.columns = cols
        cache.rows = rows
        return math.size(cols: cols, rows: rows, cellCount: subviews.count)
    }
    
    public func placeSubviews(
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
    
    static func cellSize(width: CGFloat) -> CGSize {
        .init(
            width: width,
            height: width * (2 / sqrt(3))
        )
    }
}

extension HexagonGrid {
    public struct Cache {
        var columns: Int
        var rows: Int
    }
}

#Preview {
    HexagonGrid(hexSize: 40) {
        ForEach(0..<10, id: \.self) { index in
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
