//  Created by Alexander Skorulis on 24/5/2025.

import ASKCoordinator
import Foundation
import SwiftUI

@Observable final class BattlerMenuViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    var playerStore: BattlerPlayerStore
    
    init(playerStore: BattlerPlayerStore) {
        self.playerStore = playerStore
    }
}

// MARK: - Logic

extension BattlerMenuViewModel {
    
    func start() {
        // TODO: Improve player creation
        playerStore.player = .init(money: 10)
        coordinator!.push(BattlerPath.sequence)
    }
}
