//  Created by Alexander Skorulis on 30/8/2025.

import ASKCoordinator
import Core
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class TrainerViewModel: CoordinatorViewModel {
    var coordinator: ASKCoordinator.Coordinator?
    
    var page: TrainerView.Page = .skills
    
    private let battlerStore: BattlerRunStore
    
    @Resolvable<BaseResolver>
    init(battlerStore: BattlerRunStore) {
        self.battlerStore = battlerStore
    }
}

// MARK: - Logic

extension TrainerViewModel {
    
    var player: BattlerPlayer { battlerStore.player }
    
    var availableSkills: [Skill] {
        Skill.allCases.filter { skill in
            !player.skills.isKnown(skill: skill)
        }
    }
    
    func show(skill: Skill) {
        let path = BattlerPath.skillDetails(skill, true)
        coordinator?.push(path)
    }
}
