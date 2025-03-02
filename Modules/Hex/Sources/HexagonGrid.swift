//Created by Alexander Skorulis on 28/2/2025.

import Foundation

public struct HexagonGrid {
    
    // Single hexagon calculations
    public let hexagon: Hexagon
    public let columns: Int
    public let rows: Int
    private let radius: CGFloat
    private let overlap: CGSize
    private var spacingX: CGFloat { hexagon.width - overlap.width }
    
    public init(hexagon: Hexagon, columns: Int, rows: Int) {
        self.hexagon = hexagon
        self.columns = columns
        self.rows = rows
        self.overlap = hexagon.calculateOverlap()
        self.radius = hexagon.width / 2
    }
    
    public func size(cellCount: Int) -> CGSize {
        let spacingY = hexagon.height
        let hasExtraBottom = cellCount % columns != 1 && cellCount > 1
        let bottomSpace = hasExtraBottom ? (hexagon.height / 2) : (hexagon.height / 4)
        
        let width: CGFloat
        if columns == 1 {
            width = hexagon.width
        } else {
            width = CGFloat(columns) * spacingX + hexagon.width / 4
        }
        
        return CGSize(
            width: width,
            height: CGFloat(rows) * spacingY + bottomSpace
        )
    }
    
    public func center(row: Int, column: Int) -> CGPoint {
        let corner = topCorner(row: row, column: column)
        
        return .init(
            x: corner.x + hexagon.size.width / 2,
            y: corner.y + hexagon.size.height / 2
        )
    }
    
    public func topCorner(row: Int, column: Int) -> CGPoint {
        let xOffset = CGFloat(column) * spacingX
        let yOffset = CGFloat(row) * hexagon.height + (column % 2 == 1 ? hexagon.height / 2 : 0)
        
        return .init(x: xOffset, y: yOffset)
    }
    
    func frame(row: Int, column: Int) -> CGRect {
        let origin = topCorner(row: row, column: column)
        return .init(origin: origin, size: hexagon.size)
    }
    
    func location(index: Int) -> (Int, Int) {
        let row = index / columns
        let col = index - row * columns
        return  (row, col)
    }
    
    func topCorner(index: Int) -> CGPoint {
        let loc = location(index: index)
        return topCorner(row: loc.0, column: loc.1)
    }
    
    func center(index: Int) -> CGPoint {
        let tc = topCorner(index: index)
        return .init(x: tc.x + hexagon.width / 2, y: tc.y + hexagon.height / 2)
    }
}

public extension Hexagon {
    func grid(width: CGFloat?, cellCount: Int) -> HexagonGrid {
        if let width, width > 0, width != .infinity {
            let cols: Int
            if width <= self.width {
                cols = 1
            } else {
                let remainingWidth = width - self.width
                let overlap = calculateOverlap()
                let widElement = self.width - overlap.width
                cols = min(Int(remainingWidth / widElement), cellCount) + 1
            }
            
            let rows = (cellCount + cols - 1) / cols
            return .init(hexagon: self, columns: cols, rows: rows)
        } else {
            return .init(hexagon: self, columns: cellCount, rows: 1)
        }
    }
}
