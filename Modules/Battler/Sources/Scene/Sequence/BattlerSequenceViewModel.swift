//Created by Alexander Skorulis on 26/4/2025.

import ASKCoordinator
import Combine
import Foundation

@Observable class BattlerSequenceViewModel: CoordinatorViewModel {
    
    private let generator: BattleStepGenerator
    var sequence: BattlerSequence
    var playerStore: BattlerPlayerStore
    var player: BattlerPlayer
    
    var selection: BattleSequenceIndex?
    var coordinator: Coordinator?
    
    private var subscribers: Set<AnyCancellable> = []
    
    init(
        generator: BattleStepGenerator,
        playerStore: BattlerPlayerStore,
        eventPublisher: AnyPublisher<BattlerEvent, Never>
    ) {
        self.generator = generator
        self.playerStore = playerStore
        self.player = playerStore.player
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
        }
    }
    
    private func handleStepResult() {
        if !isPlayerDead {
            let next = generator.generateStep(index: sequence.steps.count)
            sequence.steps.append(next)
        }
    }
    
    func finish() {
        coordinator?.pop()
    }
    
    func showInventory() {
        coordinator?.present(BattlerPath.equipment, style: .sheet)
    }
}
