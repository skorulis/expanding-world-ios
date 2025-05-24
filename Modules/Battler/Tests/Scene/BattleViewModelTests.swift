//  Created by Alexander Skorulis on 15/5/2025.

@testable import Battler
import Knit
import Testing

@MainActor
struct BattleViewModelTests {
 
    @Test func attack() {
        let assembler = BattlerAssembly.testing()
        let fight = BattlerFight(monsters: [.rat, .rat], difficulty: 2)
        let viewModel = assembler.resolver.battleViewModel(fight: fight)
        
        #expect(viewModel.fight.monsters[0].health.current == 10)
        #expect(viewModel.fight.monsters[1].health.current == 10)
        viewModel.perform(action: .unarmed(.kick, 4))
        #expect(viewModel.fight.monsters[0].health.current == 6)
        #expect(viewModel.fight.monsters[1].health.current == 10)
    }
}
