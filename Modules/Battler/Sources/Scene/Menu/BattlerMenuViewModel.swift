//  Created by Alexander Skorulis on 24/5/2025.

import ASKCoordinator
import Core
import Foundation
import SwiftUI

@Observable final class BattlerMenuViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    private let playerStore: BattlerPlayerStore
    private let mainPlayerStore: PlayerStore
    private let persistentStore: BattlerPersistentStore
    
    init(
        playerStore: BattlerPlayerStore,
        mainPlayerStore: PlayerStore,
        persistentStore: BattlerPersistentStore
    ) {
        self.playerStore = playerStore
        self.mainPlayerStore = mainPlayerStore
        self.persistentStore = persistentStore
    }
}

// MARK: - Logic

extension BattlerMenuViewModel {
    
    func start() {
        // TODO: Improve player creation
        playerStore.player = .init(
            money: 10,
            skills: mainPlayerStore.player.skills
        )
        coordinator!.push(BattlerPath.sequence)
    }
    
    var bestiaryUnlocked: Bool {
        persistentStore.stats.totalKills > 0
    }
    
    func showBestiary() {
        coordinator?.push(BattlerPath.bestiary)
    }
}
