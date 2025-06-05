//  Created by Alexander Skorulis on 5/6/2025.

@testable import Battler
import Testing

@MainActor
struct BattlerFightTests {
    
    @Test func reward() {
        let fight1 = BattlerFight(monsters: [.rat, .rat], difficulty: 2)
        #expect(fight1.reward == 4)
    }
}
