//  Created by Alexander Skorulis on 15/5/2025.

@testable import Battler
import Knit
import Testing

@MainActor
struct BattleViewModelTests {
 
    @Test func attack() {
        let assembler = BattlerAssembly.testing()
        let fight = BattlerFight(monsters: [.rat, .rat])
        let player = BattlerPlayer.testPlayer()
        let viewModel = assembler.resolver.battleViewModel(
            player: player,
            fight: fight,
            resultHandler: { _ in }
        )
        
        #expect(viewModel.fight.monsters[0].health.current == 10)
        #expect(viewModel.fight.monsters[1].health.current == 10)
        viewModel.perform(action: .unarmed(.kick, 4))
        #expect(viewModel.fight.monsters[0].health.current == 6)
        #expect(viewModel.fight.monsters[1].health.current == 10)
    }
}
