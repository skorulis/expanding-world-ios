//  Created by Alexander Skorulis on 2/3/2025.

import Foundation

public enum HexagonEdge: Int, CaseIterable {
    /// Flat top edge
    case top
    
    /// Right side edge at the top
    case rightTop
    
    /// Right side edge at the bottom
    case rightBottom
    
    /// Flat bottom edge
    case bottom
    
    /// Left side edge at the bottom
    case leftBottom
    
    /// Left side edge at the top
    case leftTop
    
    /// The vertices at the end of the edge
    var vertices: (HexagonVertex, HexagonVertex) {
        switch self {
        case .top:
            return (.topLeft, .topRight)
        case .rightTop:
            return (.topRight, .right)
        case .rightBottom:
            return (.right, .bottomRight)
        case .bottom:
            return (.bottomRight, .bottomLeft)
        case .leftBottom:
            return (.bottomLeft, .left)
        case .leftTop:
            return (.left, .topLeft)
        }
    }
}
