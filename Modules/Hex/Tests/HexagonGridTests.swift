//  Created by Alexander Skorulis on 3/3/2025.

import Numerics
import SnapshotTesting
import SwiftUI
import Testing
@testable import Hex

@MainActor
struct HexagonGridTests {
    
    @Test func location() {
        let grid = HexagonGrid(hexagon: .init(width: 50), columns: 3, rows: 5)
        #expect(grid.coordinate(index: 0) == .init(x: 0, y: 0))
        #expect(grid.coordinate(index: 1) == .init(x: 1, y: 0))
        #expect(grid.coordinate(index: 3) == .init(x: 0, y: 1))
        #expect(grid.coordinate(index: 5) == .init(x: 2, y: 1))
    }
    
    @Test func center() {
        let grid = HexagonGrid(hexagon: .init(width: 60), columns: 3, rows: 5)
        
        let p1 = grid.center(coord: .init(x: 0, y: 0))
        #expect(p1.x == 30)
        #expect(p1.y.isApproximatelyEqual(to: 25.98, relativeTolerance: 0.001))
        
        let p2 = grid.center(coord: .init(x: 1, y: 0))
        #expect(p2.x == 75)
        #expect(p2.y.isApproximatelyEqual(to: 51.96, relativeTolerance: 0.001))
        
        let p3 = grid.center(coord: .init(x: 0, y: 1))
        #expect(p3.x == 30)
        #expect(p3.y.isApproximatelyEqual(to: 77.94, relativeTolerance: 0.001))
        
        let p4 = grid.center(coord: .init(x: 2, y: 1))
        #expect(p4.x == 120)
        #expect(p4.y.isApproximatelyEqual(to: 77.94, relativeTolerance: 0.001))
    }
    
    @Test func coordinate() {
        let grid = HexagonGrid(hexagon: .init(width: 60), columns: 3, rows: 5)
        print(grid.coordinate(point: .init(x: 30, y: 25.98)))
        #expect(grid.coordinate(point: .init(x: 30, y: 25.98)) == .init(x: 0, y: 0))
    }
}
