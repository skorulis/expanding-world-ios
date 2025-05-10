//  Created by Alexander Skorulis on 27/4/2025.

import Foundation
import SwiftUI

@Observable final class BattleViewModel {
    
    let fight: BattlerFight
    
    init(fight: BattlerFight) {
        self.fight = fight
    }
    
    var availableActions: [Action] {
        [
            .init(
                id: "1",
                image: Image(systemName: "button.programmable"),
                name: "Attack"
            ),
            .init(
                id: "2",
                image: Image(systemName: "button.programmable"),
                name: "Block"
            ),
            .init(
                id: "3",
                image: Image(systemName: "button.programmable"),
                name: "Magic"
            ),
        ]
    }
    
    func perform(action: Action) {
        
    }
}

// MARK: - Inner Types

extension BattleViewModel {
    struct Action: Identifiable {
        let id: String
        let image: Image
        let name: String
    }
}
