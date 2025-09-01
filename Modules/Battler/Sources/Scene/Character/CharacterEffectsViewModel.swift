//  Created by Alexander Skorulis on 19/7/2025.

import Knit
import KnitMacros
import ASKCoordinator
import Foundation

final class CharacterEffectsViewModel: CoordinatorViewModel {
    var coordinator: Coordinator?
    
    private let playerStore: BattlerRunStore
    var player: BattlerPlayer { playerStore.player }
    
    @Resolvable<BaseResolver>
    init(playerStore: BattlerRunStore) {
        self.playerStore = playerStore
    }
    
    var effects: [StatusEffect] {
        []
    }
}

// MARK: - Logic

extension CharacterEffectsViewModel {
}
