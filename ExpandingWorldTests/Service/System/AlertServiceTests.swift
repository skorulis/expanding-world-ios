//Created by Alexander Skorulis on 15/2/2025.

import Testing
@testable import ExpandingWorld

@MainActor
struct AlertServiceTests {
    
    private let assembler = ExpandingWorldAssembly.testing()
    
    @Test func singleAlert() {
        let service = assembler.resolver.alertService()
        
        #expect(service.currentAlert == nil)
        service.post(message: "Message")
        #expect(service.currentAlert?.message == "Message")
        service.close()
        #expect(service.currentAlert == nil)
    }
    
    @Test func multipleAlerts() {
        let service = assembler.resolver.alertService()
        service.post(message: "Message1")
        service.post(message: "Message2")
        service.post(message: "Message3")
        
        #expect(service.currentAlert?.message == "Message1")
        service.close()
        #expect(service.currentAlert?.message == "Message2")
        service.close()
        #expect(service.currentAlert?.message == "Message3")
        service.close()
        #expect(service.currentAlert == nil)
    }
}
