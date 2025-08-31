//  Created by Alexander Skorulis on 14/7/2025.

import ASKCoordinator
import Foundation
import KnitMacros
import Knit

@Observable final class MainCharacterViewModel: CoordinatorViewModel {
    var coordinator: Coordinator?
    
    private let playerStore: BattlerRunStore
    
    @Resolvable<Resolver>
    init(playerStore: BattlerRunStore) {
        self.playerStore = playerStore
    }
}

extension MainCharacterViewModel {
    
    var player: BattlerPlayer {
        playerStore.player
    }
    
    var money: Int64 {
        player.money
    }
    
    func abilities() {
        coordinator?.push(BattlerPath.characterAbilities)
    }
    
    func equipment() {
        coordinator?.push(BattlerPath.equipment)
    }
    
    func skills() {
        coordinator?.push(BattlerPath.character)
    }
    
    func effects() {
        coordinator?.push(BattlerPath.characterEffects)
    }
}
