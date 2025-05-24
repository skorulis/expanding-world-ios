//  Created by Alexander Skorulis on 17/5/2025.

import Foundation

final class BattleFightFactory {
    
    init() {}
    
    func makeFight(difficulty: Int) -> BattlerFight {
        var monsters: [MonsterSpec] = []
        var remaining = difficulty
        while remaining > 0, monsters.count < 5 {
            let cost = monsters.count + 1
            guard let nextMonster = MonsterSpec.allCases.filter { $0.difficultyValue * cost <= remaining }.randomElement() else {
                break
            }
            monsters.append(nextMonster)
            remaining -= nextMonster.difficultyValue * cost
        }
        
        return BattlerFight(monsters: monsters, difficulty: difficulty)
    }
}
