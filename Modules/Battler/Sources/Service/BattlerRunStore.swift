//  Created by Alexander Skorulis on 20/5/2025.

import Core
import Foundation

// Stores information for the lifetime of a player run
final class BattlerRunStore: ObservableObject {
    @Published var player: BattlerPlayer
    @Published var roundStats: RoundStats = RoundStats()
    @Published var sequence = BattlerSequence(steps: [], path: [])
    
    private let playerStore: PlayerStore
    
    init(playerStore: PlayerStore) {
        self.player.inventory.add(.init(type: .leatherArmor, amount: 1))
    }
    
    func reset(player: BattlerPlayer, sequence: BattlerSequence) {
        self.player = player
        self.sequence = sequence
        self.roundStats = RoundStats()
    }

}
