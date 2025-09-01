//  Created by Alexander Skorulis on 3/8/2025.

import ASKCoordinator
import Combine
import Core
import Knit
import KnitMacros
import SwiftUI

@Observable final class SkillDetailsViewModel: CoordinatorViewModel {
    
    private let playerStore: BattlerRunStore
    private var cancellables: Set<AnyCancellable> = []
    let skill: Skill
    var showPurchase: Bool
    var player: BattlerPlayer
    
    var coordinator: Coordinator?
    
    @Resolvable<BaseResolver>
    init(@Argument skill: Skill, @Argument showPurchase: Bool, playerStore: BattlerRunStore) {
        self.skill = skill
        self.showPurchase = showPurchase
        self.playerStore = playerStore
        
        self.player = playerStore.player
        playerStore.$player.sink { [unowned self] player in
            self.player = player
        }
        .store(in: &cancellables)
    }
}

extension SkillDetailsViewModel {
    
    var state: SkillState {
        player.skills.state(skill: skill)
    }
    
    var level: Int { max(state.level, 1) }
    
    var effects: [StatusEffect] {
        skill.effects(level: level)
    }
    
    func buy() {
        guard player.money > skill.purchaseCost else { return }
        playerStore.player.skills.learn(skill: skill)
        playerStore.player.money -= skill.purchaseCost
        showPurchase = false
    }
}
