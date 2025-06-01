//  Created by Alexander Skorulis on 1/6/2025.

import Knit
import KnitMacros
import ASKCore
import Foundation
import GameSystem

final class BattlerPersistentStore: ObservableObject {
    
    private let keyValueStore: PKeyValueStore
    
    @Published var stats: BattlerStats {
        didSet {
            try? keyValueStore.set(stats)
        }
    }
    
    @Resolvable<Resolver>
    init(keyValueStore: PKeyValueStore) {
        self.keyValueStore = keyValueStore
        self.stats = keyValueStore.dataStorable()
    }
}

extension BattlerStats: DataStorable {
    static var defaultValue: BattlerStats {
        BattlerStats(killCounts: [:])
    }
    
    public static var storageKey: DataStoreKey { .battlerStats }
}
