//  Created by Alexander Skorulis on 2/3/2025.

import SnapshotTesting
import SwiftUI
import Testing
@testable import Hex

@MainActor
struct HexagonGridLayoutTests {
    
    @Test func numberedGrid() {
        let hexagon = Hexagon(width: 60)
        let grid = hexagon.grid(width: 150, cellCount: 10)
        let size = grid.size(cellCount: 10)
        let view = HexagonGridLayout(hexagon: hexagon) {
            ForEach(0..<10, id: \.self) { index in
                ZStack {
                    Text("\(index)")
                    HexagonShape()
                        .stroke(Color.blue)
                }
                .hexFrame(math: hexagon)
            }
        }
        .frame(width: size.width, height: size.height)
        
        let hostingVC: UIView = UIHostingController(rootView: view).view
        
        assertSnapshot(
            of: hostingVC,
            as: .image(size: size)
        )
    }
    
    @Test func gridHexCenter() {
        let hexagon = Hexagon(width: 60)
        let grid = hexagon.grid(width: 150, cellCount: 10)
        let size = grid.size(cellCount: 10)
        
        let view = ZStack(alignment: .topLeading) {
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
            ForEach(0..<10, id: \.self) { index in
                Circle()
                    .fill(Color.red)
                    .frame(width: 5, height: 5)
                    .position(grid.center(index: index))
            }
        }
        .frame(width: size.width, height: size.height)
        
        let hostingVC: UIView = UIHostingController(rootView: view).view
        
        assertSnapshot(
            of: hostingVC,
            as: .image(size: size)
        )
    }
}
