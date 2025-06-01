//  Created by Alexander Skorulis on 24/5/2025.

import ASKCoordinator
import Core
import Foundation
import SwiftUI

@Observable final class BattlerMenuViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    private let playerStore: BattlerPlayerStore
    private let mainPlayerStore: PlayerStore
    
    init(playerStore: BattlerPlayerStore, mainPlayerStore: PlayerStore) {
        self.playerStore = playerStore
        self.mainPlayerStore = mainPlayerStore
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
    
    func showBestiary() {
        coordinator?.push(BattlerPath.bestiary)
    }
}
