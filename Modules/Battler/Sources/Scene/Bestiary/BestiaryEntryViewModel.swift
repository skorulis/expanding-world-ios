//  Created by Alexander Skorulis on 20/5/2025.

import Knit
import KnitMacros
import ASKCoordinator
import Core
import Foundation
import SwiftUI

@Observable final class BestiaryEntryViewModel: CoordinatorViewModel {
    
    private let persistentStore: BattlerPersistentStore
    
    var coordinator: Coordinator?
    let monster: MonsterSpec
    
    @Resolvable<Resolver>
    public init(
        @Argument monster: MonsterSpec,
        persistentStore: BattlerPersistentStore
    ) {
        self.monster = monster
        self.persistentStore = persistentStore
    }
    
    var kills: Int {
        return persistentStore.stats.kills(spec: monster)
    }
} 
