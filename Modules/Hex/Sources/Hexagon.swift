//  Created by Alexander Skorulis on 2/3/2025.

import Foundation
import SwiftUI

/// Calculations for a single hexagon
public struct Hexagon {
    
    public static let aspectRatio: CGFloat = 2 / sqrt(3)
    public let width: CGFloat
    public let height: CGFloat
    
    public init(width: CGFloat) {
        self.width = width
        self.height = width / Self.aspectRatio
    }
    
    public var center: CGPoint {
        .init(x: width / 2, y: height / 2)
    }
    
    public var size: CGSize {
        .init(width: width, height: height)
    }
    
    /// Position relative to the top left corner
    public func position(vertex: HexagonVertex) -> CGPoint {
        let w2 = width / 2
        let r = vertex.relativePosition
        return .init(
            x: r.x * w2 + center.x,
            y: r.y * w2 + center.y
        )
    }
    
    public func centerPosition(edge: HexagonEdge) -> CGPoint {
        let p1 = position(vertex: edge.vertices.0)
        let p2 = position(vertex: edge.vertices.1)
        return .init(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
    }
    
    /// Calculate how much hexagons will overlap in a grid
    public func calculateOverlap() -> CGSize {
        let v1 = position(vertex: .right)
        let v2 = position(vertex: .bottomRight)
        return .init(width: v1.x - v2.x, height: v2.y - v1.y)
    }
    
    public var sideLength: CGFloat {
        let p1 = position(vertex: .bottomLeft)
        let p2 = position(vertex: .bottomRight)
        return p2.x - p1.x
    }
    
    func contains(point: CGPoint) -> Bool {
        // Convert the point to local hexagonal coordinates
        let dx = abs(point.x - center.x)
        let dy = abs(point.y - center.y)
        
        // Basic bounding box check
        if dx > sideLength * 1.5 || dy > sideLength * sqrt(3) / 2 {
            return false
        }
        
        // Check against the sloped edges
        return dy <= sqrt(3) * (sideLength - dx)
    }
}


// MARK: - SwiftUI Helpers

public extension View {
    func hexFrame(math: Hexagon) -> some View {
        self.frame(
            width: math.width,
            height: math.height
        )
    }
}
