//  Created by Alexander Skorulis on 24/5/2025.

import ASKCoordinator
import Core
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class BattlerMenuViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    private let playerStore: BattlerRunStore
    private let generator: BattleStepGenerator
    private let mainPlayerStore: PlayerStore
    private let persistentStore: BattlerPersistentStore
    
    @Resolvable<Resolver>
    init(
        playerStore: BattlerRunStore,
        generator: BattleStepGenerator,
        mainPlayerStore: PlayerStore,
        persistentStore: BattlerPersistentStore
    ) {
        self.playerStore = playerStore
        self.generator = generator
        self.mainPlayerStore = mainPlayerStore
        self.persistentStore = persistentStore
    }
}

// MARK: - Logic

extension BattlerMenuViewModel {
    
    func start() {
        persistentStore.stats.gameStarts += 1
        
        // TODO: Improve player creation
        let player = BattlerPlayer(
            money: 10,
            skills: playerStore.player.skills
        )
        let step1 = generator.generateStep(index: 0)
        let sequence = BattlerSequence(steps: [step1], path: [])
        playerStore.reset(player: player, sequence: sequence)
        
        coordinator!.push(BattlerPath.sequence)
    }
    
    var bestiaryUnlocked: Bool {
        persistentStore.stats.totalKills > 0
    }
    
    func showBestiary() {
        coordinator?.push(BattlerPath.bestiary)
    }
    
    func showStats() {
        coordinator?.push(BattlerPath.stats)
    }
}
