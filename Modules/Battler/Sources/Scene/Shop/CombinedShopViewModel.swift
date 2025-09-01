//  Created by Alexander Skorulis on 4/8/2025.

import ASKCoordinator
import Foundation
import SwiftUI
import Knit
import KnitMacros

@Observable final class CombinedShopViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    private let playerStore: BattlerRunStore
    var player: BattlerPlayer {
        didSet {
            playerStore.player = player
        }
    }
    
    private var tab: Tab = .general
    
    let generalShopViewModel: GeneralShopViewModel
    
    @Resolvable<BaseResolver>
    init(playerStore: BattlerRunStore) {
        self.player = playerStore.player
        self.playerStore = playerStore
        self.generalShopViewModel = .init(
            shop: .init(spec: ShopSpec.generalStore),
            playerStore: playerStore
        )
    }
}

extension CombinedShopViewModel {
    enum Tab {
        case general
    }
}

// MARK: - Logic

extension CombinedShopViewModel {
    
    func finish() {
        coordinator?.dismiss()
    }
}
