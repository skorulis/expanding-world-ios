//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

struct BattlerSequence {
    /// The sequence of steps in this battle
    var steps: [BattleStep]
    
    /// The path of steps that the user has chosen
    var path: [Int]
}

/// A single step in a battle sequence
struct BattleStep: Identifiable {
    
    let id = UUID()
    
    /// The type of step this is
    let stepType: BattleStepType
    
    /// The available options for this step
    let options: [BattleOption]
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
