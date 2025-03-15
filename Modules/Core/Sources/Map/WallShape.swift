//  Created by Alexander Skorulis on 15/3/2025.

import CGPointVector
import Hex
import Foundation
import SwiftUI

struct WallShape: Shape {
    let edges: [HexagonEdge]
    
    func path(in rect: CGRect) -> Path {
        if edges.isEmpty { return Path() }
        var path = Path()
        let hex = Hexagon(width: rect.width)
        let wallWidth: CGFloat = 12
        let middleHex = Hexagon(sideLength: wallWidth)
        let center = hex.center
        var hasMoved = false
        for edge in edges {
            let p1 = middleHex.position(vertex: edge.vertices.0) + center - middleHex.center
            let p2 = middleHex.position(vertex: edge.vertices.1) + center - middleHex.center
            
            let edgeC = hex.centerPosition(edge: edge)
            let dir1 = (hex.position(vertex: edge.vertices.0) - edgeC).unit
            let dir2 = (hex.position(vertex: edge.vertices.1) - edgeC).unit
            let p3 = edgeC + dir1 * wallWidth * 0.5
            
            let p4 = edgeC + dir2 * wallWidth * 0.5
            
            if !hasMoved {
                path.move(to: p1)
                hasMoved = true
            } else {
                path.addLine(to: p1)
            }
            
            path.addLine(to: p3)
            path.addLine(to: p4)
            path.addLine(to: p2)
        }
        path.closeSubpath()
        
        
        return path
    }
}

private func example(edges: [HexagonEdge]) -> some View {
    ZStack {
        WallShape(edges: edges)
            .stroke(Color.black)
        HexagonShape()
            .stroke(Color.blue)
    }
    .frame(width: 80, height: 72)
    .border(Color.red)
}

#Preview {
    
    
    
    VStack {
        example(edges: [.bottom, .leftBottom])
        example(edges: [.rightTop, .leftBottom])
        example(edges: [.leftBottom, .rightBottom])
    }
    
}
