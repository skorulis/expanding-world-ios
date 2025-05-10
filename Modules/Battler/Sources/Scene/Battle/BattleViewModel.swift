//  Created by Alexander Skorulis on 27/4/2025.

import Core
import ASKCoordinator
import Foundation
import SwiftUI

@Observable final class BattleViewModel: CoordinatorViewModel {
    
    var fight: BattlerFight
    var player: BattlerPlayer
    var coordinator: Coordinator?
    private let resultHandler: BattlerFight.ResultHandler
    private let executor = AttackExecutor()
    
    init(player: BattlerPlayer, fight: BattlerFight, resultHandler: @escaping BattlerFight.ResultHandler) {
        self.player = player
        self.fight = fight
        self.resultHandler = resultHandler
    }
    
    var currentMonster: Monster? {
        return fight.monsters.first
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
        guard fight.monsters.count > 0 else { return }
        var monster = fight.monsters[0]
        var player: any Combatant = player
        let result = executor.execute(attacker: &player, defender: &monster)
        self.fight.monsters[0] = monster
        self.onAttackComplete(result: result)
    }
    
    func complete() {
        if player.health.current <= 0 {
            resultHandler(.loss)
        } else {
            resultHandler(.win)
        }
        coordinator?.dismiss()
    }
    
    private func onAttackComplete(result: AttackResult) {
        fight.monsters = fight.monsters.filter { !result.eliminatedIDs.contains($0.id) }
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
