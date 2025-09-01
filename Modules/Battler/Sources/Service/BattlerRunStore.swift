//  Created by Alexander Skorulis on 20/5/2025.

import Core
import Foundation
import Knit
import KnitMacros

// Stores information for the lifetime of a player run
final class BattlerRunStore: ObservableObject {
    @Published var player: BattlerPlayer {
        didSet {
            self.playerStore.player.skills = player.skills
        }
    }
    @Published var roundStats: RoundStats = RoundStats()
    @Published var sequence = BattlerSequence(steps: [], path: [])
    
    private let playerStore: PlayerStore
    
    @Resolvable<BaseResolver>
    init(playerStore: PlayerStore) {
        self.playerStore = playerStore
        self.player = Self.generatePlayer(corePlayer: playerStore.player)
    }
    
    func reset(sequence: BattlerSequence) {
        self.player = Self.generatePlayer(corePlayer: playerStore.player)
        self.sequence = sequence
        self.roundStats = RoundStats()
    }
    
    private static func generatePlayer(corePlayer: Player) -> BattlerPlayer {
        // TODO: Improve player creation
        return BattlerPlayer(
            money: 10,
            skills: corePlayer.skills
        )
    }

}
