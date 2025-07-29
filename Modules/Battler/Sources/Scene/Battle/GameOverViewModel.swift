//  Created by Alexander Skorulis on 27/7/2025.

import ASKCoordinator
import Knit
import KnitMacros
import SwiftUI

@Observable final class GameOverViewModel: CoordinatorViewModel {
    var coordinator: Coordinator?
    
    private let battlerRunStore: BattlerRunStore
    
    @Resolvable<Resolver>
    init(battlerRunStore: BattlerRunStore) {
        self.battlerRunStore = battlerRunStore
    }
}

extension GameOverViewModel {
    
    var roundStats: RoundStats {
        battlerRunStore.roundStats
    }
    
    func finish() {
        coordinator?.dismiss()
    }
}
