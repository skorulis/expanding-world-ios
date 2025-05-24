//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

struct BattleStepGenerator {
    
    let fightFactory: BattleFightFactory
    let shopFactory: BattleShopFactory
    
    /// Generate a random battle step with 1-3 options
    func generateStep(index: Int) -> BattleStep {
        let optionCount = Int.random(in: 2...3)
        let stepType: BattleStepType = index % 2 == 0 ? .fight : .intermission
        let options = (0..<optionCount).map { opt in
            let diff = difficulty(for: index, option: opt)
            return generateOption(stepType: stepType, difficulty: diff)
        }
        return BattleStep(stepType: stepType, options: options)
    }
    
    private func difficulty(for index: Int, option: Int) -> Int {
        let base = pow(Double(index + option + 1), 1.5)
        return Int(ceil(base))
    }
    
    /// Generate a random battle option
    private func generateOption(stepType: BattleStepType, difficulty: Int) -> BattleOption {
        switch stepType {
        case .fight:
            let fight = fightFactory.makeFight(difficulty: difficulty)
            return .fight(fight)
        case .intermission:
            let shop = shopFactory.makeShop()
            return .shop(shop)
        }
    }
    
}
