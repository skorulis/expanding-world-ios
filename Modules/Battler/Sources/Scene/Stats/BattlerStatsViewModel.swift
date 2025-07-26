//  Created by Alexander Skorulis on 26/7/2025.

import ASKCoordinator
import Foundation
import Knit
import KnitMacros

@Observable final class BattlerStatsViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    private let store: BattlerPersistentStore
    
    @Resolvable<Resolver>
    init(store: BattlerPersistentStore) {
        self.store = store
    }
}

extension BattlerStatsViewModel {
    
    var stats: BattlerStats {
        store.stats
    }
    
    var kills: Int {
        stats.totalKills
    }
}
