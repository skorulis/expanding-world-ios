//Created by Alexander Skorulis on 26/4/2025.

import ASKCoordinator
import Core
import Combine
import Foundation

@Observable final class BattlerSequenceViewModel: CoordinatorViewModel {
    
    private let generator: BattleStepGenerator
    private let playerStore: BattlerRunStore
    private let mainPlayerStore: PlayerStore
    var player: BattlerPlayer
    var sequence: BattlerSequence
    
    var selection: BattleSequenceIndex?
    var coordinator: Coordinator?
    
    private var subscribers: Set<AnyCancellable> = []
    
    init(
        generator: BattleStepGenerator,
        playerStore: BattlerRunStore,
        mainPlayerStore: PlayerStore,
        eventPublisher: AnyPublisher<BattlerEvent, Never>
    ) {
        self.generator = generator
        self.playerStore = playerStore
        self.player = playerStore.player
        self.mainPlayerStore = mainPlayerStore
        self.sequence = playerStore.sequence
        eventPublisher.sink { [unowned self] event in
            switch event {
            case .battleFinished:
                self.handleStepResult()
            case .death:
                self.coordinator?.popToRoot()
            default:
                break
            }
        }
        .store(in: &subscribers)
        
        playerStore.$player.sink { [unowned self] value in
            self.player = value
        }
        .store(in: &subscribers)
        
        playerStore.$sequence.sink { [unowned self] value in
            self.sequence = value
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
    
    func showTrainer() {
        coordinator?.push(BattlerPath.trainer)
    }
    
    func showInventory() {
        coordinator?.present(BattlerPath.equipment, style: .sheet)
    }
}
