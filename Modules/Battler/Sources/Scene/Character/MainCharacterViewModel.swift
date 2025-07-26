//  Created by Alexander Skorulis on 14/7/2025.

import ASKCoordinator
import Foundation

@Observable final class MainCharacterViewModel: CoordinatorViewModel {
    var coordinator: Coordinator?
    
    init() {
        
    }
}

extension MainCharacterViewModel {
    func equipment() {
        coordinator?.push(BattlerPath.equipment)
    }
    
    func skills() {
        coordinator?.push(BattlerPath.character)
    }
    
    func effects() {
        coordinator?.push(BattlerPath.characterEffects)
    }
}
