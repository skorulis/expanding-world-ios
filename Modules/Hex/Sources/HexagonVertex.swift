//  Created by Alexander Skorulis on 2/3/2025.

import Foundation
import SwiftUI

public enum HexagonVertex: Int, CaseIterable {
    case right
    case bottomRight
    case bottomLeft
    case left
    case topLeft
    case topRight
    
    /// Angle from the centre of the hexagon
    var angle: Angle {
        let angle = CGFloat.pi / 3 * CGFloat(rawValue)
        return .radians(angle)
    }
    
    /// The position relative to the centre of the hexagon in a (-1, 1) coordinate space
    var relativePosition: CGPoint {
        return CGPoint(x: cos(angle.radians), y: sin(angle.radians))
    }
}
