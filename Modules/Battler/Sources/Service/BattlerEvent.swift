//  Created by Alexander Skorulis on 24/5/2025.

import Foundation

enum BattlerEvent {
    case battleFinished(BattlerFight)
    case shopFinished
    case death
    case damageTaken(Int)
    case damageDealt(Int)
}
