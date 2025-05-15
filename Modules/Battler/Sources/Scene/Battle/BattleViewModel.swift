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
    
    var playerActions: [AttackAbility] { player.abilities }
    
    func perform(action: AttackAbility) {
        guard fight.monsters.count > 0 else { return }
        var monster = fight.monsters[0]
        let result = executor.execute(attacker: &player, defender: &monster, ability: action)
        self.fight.monsters[0] = monster
        self.onAttackComplete(result: result)
        if !isFinished {
            monsterAttack()
        }
    }
    
    private func monsterAttack() {
        for i in 0..<fight.monsters.count {
            var monster = fight.monsters[i]
            let result = executor.execute(attacker: &monster, defender: &player)
            self.fight.monsters[i] = monster
            self.onAttackComplete(result: result)
        }
    }
    
    private var isFinished: Bool {
        return fight.monsters.isEmpty || player.health.current <= 0
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
