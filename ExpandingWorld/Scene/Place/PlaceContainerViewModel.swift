//Created by Alexander Skorulis on 18/2/2025.

import Foundation
import Knit
import KnitMacros

@Observable final class PlaceContainerViewModel {
    
    let playerStore: PlayerStore
    
    @Resolvable<Resolver>
    init(playerStore: PlayerStore) {
        self.playerStore = playerStore
    }
}
