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
    
    public func center(coord: Coord) -> CGPoint {
        let corner = topCorner(coord: coord)
        
        return .init(
            x: corner.x + hexagon.size.width / 2,
            y: corner.y + hexagon.size.height / 2
        )
    }
    
    public func topCorner(coord: Coord) -> CGPoint {
        let xOffset = CGFloat(coord.x) * spacingX
        let yOffset = CGFloat(coord.y) * hexagon.height + (coord.x % 2 == 1 ? hexagon.height / 2 : 0)
        
        return .init(x: xOffset, y: yOffset)
    }
    
    func frame(coord: Coord) -> CGRect {
        let origin = topCorner(coord: coord)
        return .init(origin: origin, size: hexagon.size)
    }
    
    func coordinate(index: Int) -> Coord {
        let row = index / columns
        let col = index - row * columns
        return  .init(x: col, y: row)
    }
    
    func index(x: Int, y: Int) -> Int {
        return x + y * columns
    }
    
    func topCorner(index: Int) -> CGPoint {
        let loc = coordinate(index: index)
        return topCorner(coord: loc)
    }
    
    func center(index: Int) -> CGPoint {
        let tc = topCorner(index: index)
        return .init(x: tc.x + hexagon.width / 2, y: tc.y + hexagon.height / 2)
    }
    
    public func coordinate(point: CGPoint) -> Coord? {
        for y in 0..<rows {
            for x in 0..<columns {
                let i = index(x: x, y: y)
                let c = topCorner(index: i)
                let n = CGPoint(x: point.x - c.x, y: point.y - c.y)
                if hexagon.contains(point: n) {
                    return Coord(x: x, y: y)
                }
            }
        }
        return nil
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

public extension HexagonGrid {
    struct Coord: Equatable, Codable {
        public let x: Int
        public let y: Int
        
        public init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
        
        public static var zero: Coord { .init(x: 0, y: 0) }
        
        public func move(dir: HexagonEdge) -> Coord {
            let isOddColumn = !x.isMultiple(of: 2)
            switch dir {
            case .top:
                return .init(x: x, y: y - 1)
            case .rightTop:
                let y = isOddColumn ? y : y - 1
                return .init(x: x + 1, y: y)
            case .rightBottom:
                let y = isOddColumn ? y + 1 : y
                return .init(x: x + 1, y: y)
            case .bottom:
                return .init(x: x, y: y + 1)
            case .leftBottom:
                let y = isOddColumn ? y + 1 : y
                return .init(x: x - 1, y: y)
            case .leftTop:
                let y = isOddColumn ? y : y - 1
                return .init(x: x - 1, y: y)
            }
        }
    }
}
