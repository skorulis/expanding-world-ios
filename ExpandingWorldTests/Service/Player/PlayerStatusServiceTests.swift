//Created by Alexander Skorulis on 16/2/2025.

import Testing
@testable import ExpandingWorld

@MainActor
struct PlayerStatusServiceTests {
    
    private let assembler = ExpandingWorldAssembly.testing()
    
    @Test func statusChange() {
        let service = assembler.resolver.playerStatusService()
        let playerStore = assembler.resolver.playerStore()
        #expect(playerStore.player.statuses.value(.satiation) == 10)
        service.timeAdvanced(seconds: 3600)
        #expect(playerStore.player.statuses.value(.satiation) == 9.5)
    }
}

