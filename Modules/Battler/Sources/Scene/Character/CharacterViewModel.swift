//  Created by Alexander Skorulis on 25/5/2025.

import ASKCoordinator
import Core
import Foundation
import SwiftUI

@Observable final class CharacterViewModel: CoordinatorViewModel {
    
    private let playerStore: BattlerRunStore
    var player: BattlerPlayer { playerStore.player }
    
    var coordinator: Coordinator?
    
    init(playerStore: BattlerRunStore) {
        self.playerStore = playerStore
    }
}

// MARK: - Logic

extension CharacterViewModel {
    
    var knownSkills: [Skill] {
        return Skill.allCases.filter {
            player.skills.isKnown(skill: $0)
        }
    }
    
    func showDetails(skill: Skill) {
        self.coordinator?.push(BattlerPath.skillDetails(skill, false))
    }
}
