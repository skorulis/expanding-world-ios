//Created by Alexander Skorulis on 18/2/2025.

import Core
import Foundation
import Knit
import KnitMacros

@Observable final class PlaceContainerViewModel {
    
    let playerStore: PlayerStore
    
    @Resolvable<BaseResolver>
    init(playerStore: PlayerStore) {
        self.playerStore = playerStore
    }
}
