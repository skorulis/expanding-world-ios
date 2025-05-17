//  Created by Alexander Skorulis on 17/5/2025.

import Foundation

final class BattleFightFactory {
    
    init() {}
    
    func makeFight(difficulty: Int) -> BattlerFight {
        return BattlerFight(monsters: [.rat])
    }
}
