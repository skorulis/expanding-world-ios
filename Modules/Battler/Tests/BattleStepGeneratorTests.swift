//  Created by Alexander Skorulis on 26/4/2025.

@testable import Battler
import Testing

struct BattleStepGeneratorTests {
    
    @Test func generateStep1() {
        let generator = BattleStepGenerator()
        let step = generator.generateStep(index: 0)
        #expect(step.stepType == .fight)
    }
}
