//  Created by Alexander Skorulis on 26/4/2025.

@testable import Battler
import Testing

@MainActor
struct BattleStepGeneratorTests {
    
    @Test func generateStep1() {
        let assembler = BattlerAssembly.testing()
        let generator = assembler.resolver.battleStepGenerator()
        let step = generator.generateStep(index: 0)
        #expect(step.stepType == .fight)
    }
}
