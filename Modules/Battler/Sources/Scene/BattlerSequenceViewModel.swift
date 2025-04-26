//Created by Alexander Skorulis on 26/4/2025.

import Foundation

@Observable class BattlerSequenceViewModel {
    
    private let generator: BattleStepGenerator
    var sequence: BattlerSequence
    
    init(generator: BattleStepGenerator) {
        self.generator = generator
        let step1 = generator.generateStep(index: 0)
        self.sequence = .init(steps: [step1], path: [])
    }
}
