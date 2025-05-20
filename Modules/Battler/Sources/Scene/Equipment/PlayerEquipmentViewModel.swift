//  Created by Alexander Skorulis on 19/5/2025.

import ASKCoordinator
import Foundation
import SwiftUI

@Observable final class PlayerEquipmentViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    private let playerStore: PlayerStore
    
    init(playerStore: PlayerStore) {
        self.playerStore = playerStore
    }
}
