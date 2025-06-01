//  Created by Alexander Skorulis on 20/5/2025.

import Knit
import KnitMacros
import ASKCoordinator
import Core
import Foundation
import SwiftUI

@Observable final class BestiaryViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    private let persistentStore: BattlerPersistentStore
    
    @Resolvable<Resolver>
    public init(persistentStore: BattlerPersistentStore) {
        self.persistentStore = persistentStore
    }
}

// MARK: - Logic

extension BestiaryViewModel {
    var entries: [MonsterSpec] {
        MonsterSpec.allCases.filter { kills(monster: $0) > 0 }
    }
    
    func kills(monster: MonsterSpec) -> Int {
        persistentStore.stats.kills(spec: monster)
    }
    
    func select(_ entry: MonsterSpec) {
        coordinator?.push(BattlerPath.bestiaryEntry(entry))
    }
}
