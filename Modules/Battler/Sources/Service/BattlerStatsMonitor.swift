//  Created by Alexander Skorulis on 27/7/2025.

import ASKCore
import Combine
import Foundation
import Knit
import KnitMacros

public final class BattlerStatsMonitor {
    
    private let eventPublisher: AnyPublisher<BattlerEvent, Never>
    private var subscribers: Set<AnyCancellable> = []
    
    private let battlerRunStore: BattlerRunStore
    private let battlerPersistentStore: BattlerPersistentStore
    
    @Resolvable<BaseResolver>
    init(
        eventPublisher: AnyPublisher<BattlerEvent, Never>,
        battlerRunStore: BattlerRunStore,
        battlerPersistentStore: BattlerPersistentStore
    ) {
        self.eventPublisher = eventPublisher
        self.battlerRunStore = battlerRunStore
        self.battlerPersistentStore = battlerPersistentStore
        
        eventPublisher.sink { [unowned self] event in
            self.process(event)
        }
        .store(in: &subscribers)
    }
    
    private func process(_ event: BattlerEvent) {
        switch event {
        case let .battleFinished(battle):
            battlerRunStore.roundStats.fightsWon += 1
            battlerPersistentStore.stats.moneyEarned += battle.reward
        case let .damageTaken(dam):
            battlerRunStore.roundStats.damageTaken += dam
            battlerPersistentStore.stats.damageTaken += dam
        case let .damageDealt(dam):
            battlerRunStore.roundStats.damageDealt += dam
            battlerPersistentStore.stats.damageDealt += dam
        case .death:
            battlerPersistentStore.stats.deaths += 1
        }
    }
}
