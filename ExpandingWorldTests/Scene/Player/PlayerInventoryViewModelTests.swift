//Created by Alexander Skorulis on 16/2/2025.

import Testing
@testable import ExpandingWorld

@MainActor
struct PlayerInventoryViewModelTests {
    
    private let assembler = ExpandingWorldAssembly.testing()
    
    private var player: Player { assembler.resolver.playerStore().player }
    
    @Test func consume() {
        let viewModel = assembler.resolver.playerInventoryViewModel()
        let playerStore = assembler.resolver.playerStore()
        let timeStore = assembler.resolver.timeStore()
        playerStore.player.inventory.add(.init(type: .grog, amount: 10))
        viewModel.onAction(item: .init(type: .grog, amount: 1), action: .consume)
        
        #expect(player.inventory.count(.grog) == 9)
        #expect(player.statuses.intoxication == 1)
        #expect(timeStore.seconds == 90)
    }
    
}
