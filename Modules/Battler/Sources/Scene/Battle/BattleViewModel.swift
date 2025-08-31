//  Created by Alexander Skorulis on 27/4/2025.

import Knit
import KnitMacros
import Core
import Combine
import ASKCoordinator
import Foundation
import SwiftUI

@Observable final class BattleViewModel: CoordinatorViewModel {
    
    var fight: BattlerFight
    var totalSkillGain: [Skill: Int] = [:]
    private let battlerRunStore: BattlerRunStore
    private let persistentStore: BattlerPersistentStore
    private let eventPublisher: PassthroughSubject<BattlerEvent, Never>
    var player: BattlerPlayer {
        didSet {
            battlerRunStore.player = player
        }
    }
    var coordinator: Coordinator?
    private let executor = AttackExecutor(random: SystemRandomNumberGenerator())
    
    var selectedMonsterID: UUID?
    
    var logs: [FightLog] = []
    
    @Resolvable<Resolver>
    init(
        @Argument fight: BattlerFight,
        battlerRunStore: BattlerRunStore,
        eventPublisher: PassthroughSubject<BattlerEvent, Never>,
        persistentStore: BattlerPersistentStore
    ) {
        self.battlerRunStore = battlerRunStore
        self.player = battlerRunStore.player
        self.eventPublisher = eventPublisher
        self.fight = fight
        self.persistentStore = persistentStore
        logs.append(.init(message: "The fight started"))
    }
    
    var currentMonster: Monster? {
        guard let selectedMonsterID else {
            return fight.monsters.first
        }
        return fight.monsters.first(where: { $0.id == selectedMonsterID })
    }
    
    var monsterIndex: Int {
        guard let selectedMonsterID else {
            return 0
        }
        return fight.monsters.firstIndex(where: { $0.id == selectedMonsterID} ) ?? 0
    }
    
    var selectedBinding: Binding<UUID?> {
        return .init { [unowned self] in
            self.currentMonster?.id
        } set: { newValue in
            self.selectedMonsterID = newValue
        }
    }
    
    var playerActions: [AttackAbility] { player.allActions }
    
    func hitChance(action: AttackAbility) -> Double {
        guard let currentMonster else {
            return 0
        }
        var context = AttackContext(attacker: player, defender: currentMonster, ability: action)
        return executor.hitChance(context: context)
    }
    
    func perform(action: AttackAbility) {
        guard fight.monsters.count > 0 else { return }
        let monsterIndex = fight.monsters.firstIndex(where: { $0.id == selectedMonsterID }) ?? 0
        var monster = fight.monsters[monsterIndex]
        let result = executor.execute(attacker: &player, defender: &monster, ability: action)
        if let damage = result.context.damage {
            eventPublisher.send(.damageDealt(damage))
        }
        print("== PLAYER ATTACK == ")
        result.context.logAttack()
        logs.insert(contentsOf: result.logs, at: 0)
        self.fight.monsters[monsterIndex] = monster
        self.onAttackComplete(result: result)
        totalSkillGain = totalSkillGain.adding(other: result.context.attackerSkillXP)
        if !isFinished {
            monsterAttack()
        }
    }
    
    private func monsterAttack() {
        for i in 0..<fight.monsters.count {
            var monster = fight.monsters[i]
            let result = executor.execute(attacker: &monster, defender: &player)
            if let damage = result.context.damage {
                eventPublisher.send(.damageTaken(damage))
            }
            print("== MONSTER ATTACK == ")
            result.context.logAttack()
            logs.insert(contentsOf: result.logs, at: 0)
            self.fight.monsters[i] = monster
            self.onAttackComplete(result: result)
            totalSkillGain = totalSkillGain.adding(other: result.context.defenderSkillXP)
        }
        if player.health.current <= 0 {
            eventPublisher.send(.death)
            coordinator?.push(BattlerPath.gameOver)
        }
    }
    
    private var isFinished: Bool {
        return fight.monsters.isEmpty || player.health.current <= 0
    }
    
    func complete() {
        player.health.refill()
        player.money += fight.reward
        eventPublisher.send(.battleFinished(fight))
        coordinator?.push(BattlerPath.combinedShop)
    }
    
    private func onAttackComplete(result: AttackResult) {
        let deadMonsters = fight.monsters.filter { result.eliminatedIDs.contains($0.id) }
        for monster in deadMonsters {
            persistentStore.stats.addKill(spec: monster.spec)
        }
        fight.monsters = fight.monsters.filter { !result.eliminatedIDs.contains($0.id) }
    }
}

extension Dictionary where Key == Skill, Value == Int {
    func adding(other: Dictionary<Skill, Int>) -> Dictionary<Skill, Int> {
        var result = self
        for (key, value) in other {
            result[key] = (result[key] ?? 0) + (other[key] ?? 0)
        }
        return result
    }
}
