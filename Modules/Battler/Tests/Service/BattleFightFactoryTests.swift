//  Created by Alexander Skorulis on 24/5/2025.

@testable import Battler
import Testing

@MainActor
struct BattleFightFactoryTests {
        
    private let factory = BattleFightFactory()
    
    @Test func baseFight() {
        let fight = factory.makeFight(difficulty: 1)
        #expect(fight.monsters.count == 1)
        #expect(fight.difficulty == 1)
    }
    
    @Test func highDifficultyFight() {
        let fight = factory.makeFight(difficulty: 100)
        #expect(fight.monsters.count == 5)
        #expect(fight.difficulty == 100)
    }
    
}

