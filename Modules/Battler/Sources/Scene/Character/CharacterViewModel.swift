//  Created by Alexander Skorulis on 25/5/2025.

import Core
import Foundation
import SwiftUI

@Observable final class CharacterViewModel {
    
    private let playerStore: BattlerPlayerStore
    var player: BattlerPlayer { playerStore.player }
    
    init(playerStore: BattlerPlayerStore) {
        self.playerStore = playerStore
    }
    
    var knownSkills: [Skill] {
        return Skill.allCases.filter {
            player.skills.isKnown(skill: $0)
        }
    }
}
