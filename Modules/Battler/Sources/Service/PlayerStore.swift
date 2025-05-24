//  Created by Alexander Skorulis on 20/5/2025.

import Foundation

final class BattlerPlayerStore: ObservableObject {
    @Published var player: BattlerPlayer
    
    init(player: BattlerPlayer) {
        self.player = player
        self.player.inventory.add(.init(type: .leatherArmor, amount: 1))
    }

}
