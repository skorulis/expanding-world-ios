//Created by Alexander Skorulis on 26/4/2025.

import ASKCoordinator
import Foundation

@Observable class BattlerSequenceViewModel: CoordinatorViewModel {
    
    private let generator: BattleStepGenerator
    var sequence: BattlerSequence
    
    var selection: BattleSequenceIndex?
    var coordinator: Coordinator?
    
    init(generator: BattleStepGenerator) {
        self.generator = generator
        let step1 = generator.generateStep(index: 0)
        self.sequence = .init(steps: [step1], player: .testPlayer(), path: [])
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
    
    func detailsSelected() {
        guard let selection else { return }
        let option = sequence.option(index: selection)
        sequence.path.append(selection.optionIndex)
        switch option {
        case let .fight(fight):
            let path = BattlerPath.battle(sequence.player, fight) { [weak self] result in
                self?.handleFightResult(result: result)
            }
            coordinator?.present(path, style: .fullScreen)
        case let .shop(shop):
            let path = BattlerPath.shop(shop)
            coordinator?.present(path, style: .fullScreen)
        }
    }
    
    private func handleFightResult(result: BattlerFight.Result) {
        let next = generator.generateStep(index: sequence.steps.count)
        sequence.steps.append(next)
        print("Finish")
    }
    
    func showInventory() {
        coordinator?.present(BattlerPath.equipment, style: .sheet)
    }
}
