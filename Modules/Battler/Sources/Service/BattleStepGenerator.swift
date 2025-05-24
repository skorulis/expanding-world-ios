//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

struct BattleStepGenerator {
    
    let fightFactory: BattleFightFactory
    let shopFactory: BattleShopFactory
    
    /// Generate a random battle step with 1-3 options
    func generateStep(index: Int) -> BattleStep {
        let optionCount = Int.random(in: 2...3)
        let stepType: BattleStepType = index % 2 == 0 ? .fight : .intermission
        let options = (0..<optionCount).map { _ in generateOption(stepType: stepType) }
        return BattleStep(stepType: stepType, options: options)
    }
    
    /// Generate a random battle option
    private func generateOption(stepType: BattleStepType) -> BattleOption {
        switch stepType {
        case .fight:
            let fight = fightFactory.makeFight(difficulty: 1)
            return .fight(fight)
        case .intermission:
            let shop = shopFactory.makeShop()
            return .shop(shop)
        }
    }
    
}
