//  Created by Alexander Skorulis on 3/3/2025.

import Testing
@testable import Hex

struct HexagonTests {

    @Test func contains() {
        let hexagon = Hexagon(width: 80)
        var p1 = hexagon.position(vertex: .right)
        p1.x -= 0.01
        #expect(hexagon.contains(point: .zero) == false)
        #expect(hexagon.contains(point: p1) == true)
    }
    
}
