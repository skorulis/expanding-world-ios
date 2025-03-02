//Created by Alexander Skorulis on 15/2/2025.

import SwiftUI

public struct HexagonGridLayout: Layout {
    
    public func makeCache(subviews: Subviews) -> HexagonGrid {
        return .init(hexagon: hexagon, columns: subviews.count, rows: 1)
    }
    
    let hexagon: Hexagon
    
    var hexSize: CGFloat { hexagon.width / 2}
    var hexHeight: CGFloat { hexagon.height }
    
    public init(hexagon: Hexagon) {
        self.hexagon = hexagon
    }
    
    public init(hexSize: CGFloat) {
        self.hexagon = .init(width: hexSize * 2)
    }
    
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout HexagonGrid
    ) -> CGSize {
        if subviews.isEmpty { return .zero }
        cache = hexagon.grid(width: proposal.width, cellCount: subviews.count)
        return cache.size(cellCount: subviews.count)
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) {        
        for (index, subview) in subviews.enumerated() {
            let row = index / cache.columns
            let col = index % cache.columns
            let offset = cache.topCorner(row: row, column: col)
            
            subview.place(
                at: CGPoint(
                    x: bounds.origin.x + offset.x,
                    y: bounds.origin.y + offset.y
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

// MARK: - Previews

#Preview {
    let hexagon = Hexagon(width: 80)
    let grid = hexagon.grid(width: 320, cellCount: 10)
    ZStack(alignment: .topLeading) {
        HexagonGridLayout(hexagon: hexagon) {
            ForEach(0..<10, id: \.self) { index in
                ZStack {
                    Text("\(index)")
                    HexagonShape()
                        .stroke(Color.blue)
                }
                .hexFrame(math: hexagon)
            }
        }
        Circle()
            .fill(Color.yellow)
            .frame(width: 20)
            .offset(x: grid.center(index: 3).x, y: grid.center(index: 3).y )
    }
    .frame(maxWidth: 320)
    .border(Color.red)
    .padding()
    
}
