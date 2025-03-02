//  Created by Alexander Skorulis on 2/3/2025.

import SnapshotTesting
import SwiftUI
import Testing
@testable import Hex

@MainActor
struct HexagonShapeTests {
    
    @Test func basicHexagon() async throws {
        let view = HexagonShape()
            .stroke(Color.black)
            .frame(width: 120)
        
        let hostingVC: UIView = UIHostingController(rootView: view).view
        
        assertSnapshot(
            of: hostingVC,
            as: .image(size: .init(width: 120, height: 120))
        )
    }
    
    @Test func hexagonVerticies() async throws {
        let math = Hexagon(width: 120)
        
        let view = ZStack(alignment: .topLeading) {
            HexagonShape()
                .stroke(Color.black)
            
            pointView(.red, math.position(vertex: .topLeft))
            pointView(.blue, math.position(vertex: .topRight))
            pointView(.green, math.position(vertex: .right))
            pointView(.orange, math.position(vertex: .left))
        }
        .hexFrame(math: math)
        .padding(10)
        
        let hostingVC: UIView = UIHostingController(rootView: view).view
        
        assertSnapshot(
            of: hostingVC,
            as: .image(size: .init(width: math.width + 20, height: math.height + 20))
        )
    }
    
    @Test func hexagonEdgeCenters() async throws {
        let math = Hexagon(width: 120)
        
        let view = ZStack(alignment: .topLeading) {
            HexagonShape()
                .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                .foregroundColor(.black)
            
            pointView(.red, math.centrePosition(edge: .top))
            pointView(.blue, math.centrePosition(edge: .rightTop))
            pointView(.green, math.centrePosition(edge: .rightBottom))
            pointView(.orange, math.centrePosition(edge: .bottom))
            pointView(.purple, math.centrePosition(edge: .leftBottom))
            pointView(.yellow, math.centrePosition(edge: .leftTop))
        }
        .hexFrame(math: math)
        .padding(10)
        
        let hostingVC: UIView = UIHostingController(rootView: view).view
        
        assertSnapshot(
            of: hostingVC,
            as: .image(size: .init(width: math.width + 20, height: math.height + 20))
        )
    }
    
    func pointView(_ color: Color, _ point: CGPoint) -> some View {
        Circle()
            .fill(color)
            .frame(width: 3, height: 3)
            .position(point)
    }

}
