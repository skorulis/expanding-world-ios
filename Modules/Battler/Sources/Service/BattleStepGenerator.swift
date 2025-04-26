//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

final class BattleStepGenerator {
    
    /// Generate a random battle step with 1-3 options
    func generateStep(index: Int) -> BattleStep {
        let optionCount = Int.random(in: 1...3)
        let stepType: BattleStepType = index % 2 == 0 ? .fight : .intermission
        let options = (0..<optionCount).map { _ in generateOption(stepType: stepType) }
        return BattleStep(stepType: stepType, options: options, chosenOptionIndex: nil)
    }
    
    /// Generate a random battle option
    private func generateOption(stepType: BattleStepType) -> BattleOption {
        switch stepType {
        case .fight:
            return .fight
        case .intermission:
            return .shop
        }
    }
    
}
