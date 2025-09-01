//  Created by Alexander Skorulis on 31/8/2025.

import ASKCoordinator
import Knit
import KnitMacros
import SwiftUI

@Observable final class CharacterAbilitiesViewModel: CoordinatorViewModel {
 
    var coordinator: Coordinator?
    
    private let playerStore: BattlerRunStore
    var player: BattlerPlayer { playerStore.player }
    
    var selectedIndex: Int = 0
    
    @Resolvable<BaseResolver>
    init(playerStore: BattlerRunStore) {
        self.playerStore = playerStore
    }
}

// MARK: - Logic

extension CharacterAbilitiesViewModel {
    
    var selectedAbility: AttackAbility {
        if selectedIndex >= player.abilities.count {
            return player.abilities[0]
        }
        return player.abilities[selectedIndex]
    }
    
    func select(index: Int) {
        self.selectedIndex = index
    }
    
    var context: AttackContext {
        AttackContext(attacker: player, defender: Monster(spec: .rat), ability: selectedAbility)
    }
}
