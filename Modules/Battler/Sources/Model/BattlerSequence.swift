//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

struct BattlerSequence {
    /// The sequence of steps in this battle
    var steps: [BattleStep]
}

/// A single step in a battle sequence
struct BattleStep {
    
    /// The type of step this is
    let stepType: BattleStepType
    
    /// The available options for this step
    let options: [BattleOption]
    /// The index of the chosen option, nil if not yet chosen
    var chosenOptionIndex: Int?
}

enum BattleStepType: CaseIterable {
    case fight
    case intermission
}

/// A single option that can be chosen in a battle step
enum BattleOption {
    case fight
    case shop
}
