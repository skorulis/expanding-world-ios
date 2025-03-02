//  Created by Alexander Skorulis on 3/3/2025.

import SnapshotTesting
import SwiftUI
import Testing
@testable import Hex

@MainActor
struct HexagonGridTests {
    
    @Test func location() {
        let grid = HexagonGrid(hexagon: .init(width: 50), columns: 3, rows: 5)
        #expect(grid.location(index: 0) == (0, 0))
        #expect(grid.location(index: 1) == (0, 1))
        #expect(grid.location(index: 3) == (1, 0))
        #expect(grid.location(index: 5) == (1, 2))
    }
}
