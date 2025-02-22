//Created by Alexander Skorulis on 14/2/2025.

import Testing
@testable import ExpandingWorld

@MainActor
struct ActionServiceTests {
    
    private let assembler = ExpandingWorldAssembly.testing()
    private let place1 = Place(spec: PlaceLibrary.tavern1)
    
    @Test func lookAtTavern() async throws {
        let time = assembler.resolver.timeStore()
        let knowledge = assembler.resolver.knowledgeStore()
        let sut = assembler.resolver.actionService()
        sut.perform(action: .look, place: place1)
        
        #expect(time.seconds == 10)
        #expect(knowledge.knowledge.placeFeatures.contains(.pinkyTavernBar))
    }
    
    @Test func resolveAndEnact() {
        let sut = assembler.resolver.actionService()
        let alertService = assembler.resolver.alertService()
        sut.perform(action: .talk(.init(conditionals: [], fallback: [.alert("Hello")])), place: place1)
        
        #expect(alertService.currentAlert?.message == "Hello")
    }

}

