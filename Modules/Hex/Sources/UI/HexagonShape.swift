//Created by Alexander Skorulis on 15/2/2025.

import SwiftUI

public struct HexagonShape: Shape {
    
    public init() {}
    
    public static let aspectRatio: CGFloat = 2 / sqrt(3)
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let math = Hexagon(width: rect.width)
        let size = math.width / 2
        let corners = HexagonVertex.allCases.map { vertex in
            let offset = vertex.relativePosition
            return CGPoint(
                x: offset.x * size + rect.midX,
                y: offset.y * size + rect.midY
            )
        }

        path.move(to: corners[0])
        corners[1..<6].forEach { point in
            path.addLine(to: point)
        }

        path.closeSubpath()

        return path
    }
}

#Preview {
    HexagonShape()
        .stroke(Color.black)
        .frame(width: 100, height: 100)
        .border(Color.red)
}
