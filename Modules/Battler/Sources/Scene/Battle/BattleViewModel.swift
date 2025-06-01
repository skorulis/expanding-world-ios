//  Created by Alexander Skorulis on 27/4/2025.

import Core
import Combine
import ASKCoordinator
import Foundation
import SwiftUI

@Observable final class BattleViewModel: CoordinatorViewModel {
    
    var fight: BattlerFight
    private let playerStore: BattlerPlayerStore
    private let eventPublisher: PassthroughSubject<BattlerEvent, Never>
    var player: BattlerPlayer {
        didSet {
            playerStore.player = player
        }
    }
    var coordinator: Coordinator?
    private let executor = AttackExecutor(random: SystemRandomNumberGenerator())
    
    init(
        fight: BattlerFight,
        playerStore: BattlerPlayerStore,
        eventPublisher: PassthroughSubject<BattlerEvent, Never>
    ) {
        self.playerStore = playerStore
        self.player = playerStore.player
        self.eventPublisher = eventPublisher
        self.fight = fight
    }
    
    var currentMonster: Monster? {
        return fight.monsters.first
    }
    
    var playerActions: [AttackAbility] {
        var actions = player.abilities
        if player.inventory.equipped(.mainHand) == nil {
            actions.append(.unarmed(.punch, 2...4))
        }
        for item in player.inventory.allEquipped where item.type.attack != nil {
            actions.append(.weapon(item))
        }
        return actions
    }
    
    func perform(action: AttackAbility) {
        guard fight.monsters.count > 0 else { return }
        var monster = fight.monsters[0]
        let result = executor.execute(attacker: &player, defender: &monster, ability: action)
        print("== PLAYER ATTACK == ")
        result.context.logAttack()
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
            print("== MONSTER ATTACK == ")
            result.context.logAttack()
            self.fight.monsters[i] = monster
            self.onAttackComplete(result: result)
        }
    }
    
    private var isFinished: Bool {
        return fight.monsters.isEmpty || player.health.current <= 0
    }
    
    func complete() {
        if player.health.current <= 0 {
            eventPublisher.send(.stepFinished)
        } else {
            player.health.refill()
            eventPublisher.send(.stepFinished)
        }
        coordinator?.dismiss()
    }
    
    private func onAttackComplete(result: AttackResult) {
        fight.monsters = fight.monsters.filter { !result.eliminatedIDs.contains($0.id) }
    }
}
