//  Created by Alexander Skorulis on 3/8/2025.

import ASKCoordinator
import Core
import Knit
import KnitMacros
import SwiftUI

@Observable final class SkillDetailsViewModel: CoordinatorViewModel {
    
    private let playerStore: BattlerRunStore
    let skill: Skill
    
    var coordinator: Coordinator?
    
    @Resolvable<Resolver>
    init(@Argument skill: Skill, playerStore: BattlerRunStore) {
        self.skill = skill
        self.playerStore = playerStore
        
    }
}

extension SkillDetailsViewModel {
    var state: SkillState {
        playerStore.player.skills.state(skill: skill)
    }
    
    var effects: [StatusEffect] {
        skill.effects(level: state.level)
    }
}
