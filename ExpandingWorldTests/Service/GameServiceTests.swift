//Created by Alexander Skorulis on 15/2/2025.

import Testing
@testable import ExpandingWorld

@MainActor
struct GameServiceTests {
    
    private let assembler = ExpandingWorldAssembly.testing()
    
    @Test func startGame() throws {
        let service = assembler.resolver.gameService()
        let alerts = assembler.resolver.alertService()
        
        service.startNewGame()
        #expect(alerts.currentAlert != nil)
    }
    
}
