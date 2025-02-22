//Created by Alexander Skorulis on 14/2/2025.

import Testing
@testable import ExpandingWorld

@MainActor
struct ActionServiceTests {
    
    private let assembler = ExpandingWorldAssembly.testing()
    
    @Test func lookAtTavern() async throws {
        let place = Place(spec: PlaceLibrary.tavern1)
        let time = assembler.resolver.timeStore()
        let knowledge = assembler.resolver.knowledgeStore()
        let sut = assembler.resolver.actionService()
        sut.perform(action: .look, place: place)
        
        #expect(time.seconds == 10)
        #expect(knowledge.knowledge.placeFeatures.contains(.pinkyTavernBar))
    }

}

