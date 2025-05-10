//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

struct BattlerSequence: Sendable {
    /// The sequence of steps in this battle
    var steps: [BattleStep]
    
    /// The player competing
    var player: BattlerPlayer
    
    /// The path of steps that the user has chosen
    var path: [Int]
    
    func option(index: BattleSequenceIndex) -> BattleOption {
        steps[index.stepIndex].options[index.optionIndex]
    }
}

struct BattleSequenceIndex {
    let stepIndex: Int
    let optionIndex: Int
}

/// A single step in a battle sequence
struct BattleStep: Identifiable, Sendable {
    
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
enum BattleOption: Sendable {
    case fight(BattlerFight)
    case shop
    
    static func testFight() -> BattleOption {
        .fight(.testFight())
    }
}

extension BattlerPlayer {
    static func testPlayer() -> BattlerPlayer {
        .init()
    }
}

extension BattlerFight {
    static func testFight() -> BattlerFight {
        .init(monsters: [.rat])
    }
}
