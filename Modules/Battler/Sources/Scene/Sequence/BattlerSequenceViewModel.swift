//Created by Alexander Skorulis on 26/4/2025.

import ASKCoordinator
import Core
import Combine
import Foundation

@Observable final class BattlerSequenceViewModel: CoordinatorViewModel {
    
    private let generator: BattleStepGenerator
    private let playerStore: BattlerPlayerStore
    private let mainPlayerStore: PlayerStore
    var sequence: BattlerSequence
    var player: BattlerPlayer
    
    var selection: BattleSequenceIndex?
    var coordinator: Coordinator?
    
    private var subscribers: Set<AnyCancellable> = []
    
    init(
        generator: BattleStepGenerator,
        playerStore: BattlerPlayerStore,
        mainPlayerStore: PlayerStore,
        eventPublisher: AnyPublisher<BattlerEvent, Never>
    ) {
        self.generator = generator
        self.playerStore = playerStore
        self.player = playerStore.player
        self.mainPlayerStore = mainPlayerStore
        let step1 = generator.generateStep(index: 0)
        self.sequence = .init(steps: [step1], path: [])
        eventPublisher.sink { [unowned self] event in
            self.handleStepResult()
        }
        .store(in: &subscribers)
        playerStore.$player.sink { [unowned self] value in
            self.player = value
        }
        .store(in: &subscribers)
    }
}

// MARK: - Inner Types

extension BattlerSequenceViewModel {
    enum Presentation {
        case fight(BattlerFight)
    }
}

// MARK: - Logic

extension BattlerSequenceViewModel {
    
    var isPlayerDead: Bool { player.health.current <= 0}
    
    func detailsSelected() {
        guard let selection else { return }
        let option = sequence.option(index: selection)
        sequence.path.append(selection.optionIndex)
        self.selection = nil
        switch option {
        case let .fight(fight):
            let path = BattlerPath.battle(fight)
            coordinator?.present(path, style: .fullScreen)
        case let .shop(shop):
            let path = BattlerPath.shop(shop)
            coordinator?.present(path, style: .fullScreen)
        case let .temple(temple):
            let path = BattlerPath.temple(temple)
            coordinator?.present(path, style: .fullScreen)
        }
    }
    
    private func handleStepResult() {
        if !isPlayerDead {
            let next = generator.generateStep(index: sequence.steps.count)
            sequence.steps.append(next)
        }
    }
    
    func finish() {
        self.mainPlayerStore.player.skills = player.skills
        coordinator?.pop()
    }
    
    func showInventory() {
        coordinator?.present(BattlerPath.equipment, style: .sheet)
    }
}
