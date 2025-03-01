//Created by Alexander Skorulis on 28/2/2025.

import Foundation

public struct HexagonMath {
    public let width: CGFloat
    public let hexHeight: CGFloat
    
    public init(width: CGFloat) {
        self.width = width
        self.hexHeight = width * sqrt(3) / 2
    }
    
    public func fit(width: CGFloat?, cellCount: Int) -> (Int, Int) {
        if let width, width > 0, width != .infinity {
            let widElement = self.width * 0.75
            let cols = max(min(Int(width / widElement), cellCount), 1)
            let rows = (cellCount + cols - 1) / cols
            return (cols, rows)
        } else {
            return (cellCount, 1)
        }
    }
    
    public func size(cols: Int, rows: Int, cellCount: Int) -> CGSize {
        let spacingX = width * 0.75
        let spacingY = hexHeight
        let hasExtraBottom = cellCount % cols != 1 && cellCount > 1
        let bottomSpace = hasExtraBottom ? (hexHeight / 2) : (hexHeight / 4)
        
        return CGSize(
            width: CGFloat(cols) * spacingX + width / 4,
            height: CGFloat(rows) * spacingY + bottomSpace
        )
    }
}
