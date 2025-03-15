//  Created by Alexander Skorulis on 15/3/2025.

import Testing
@testable import Core

struct GameMapTests {
    
    @Test func wa() {
        var map = GameMap(width: 2, height: 2, tiles: nil)
        map[.init(x: 0, y: 0)].feature = .wall
        map[.init(x: 0, y: 1)].feature = .wall
        map.updateFeatureConnections()
        
        #expect(map[.init(x: 0, y: 0)].wallEdges == [.bottom])
        #expect(map[.init(x: 0, y: 1)].wallEdges == [.top])
    }
}
