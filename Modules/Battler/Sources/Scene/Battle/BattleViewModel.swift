//  Created by Alexander Skorulis on 27/4/2025.

import Foundation
@Observable final class BattleViewModel {
    
    let fight: BattlerFight
    
    init(fight: BattlerFight) {
        self.fight = fight
    }
}
