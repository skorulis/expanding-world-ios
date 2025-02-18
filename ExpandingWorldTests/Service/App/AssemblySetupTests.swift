//Created by Alexander Skorulis on 17/2/2025.

import ASKCore
import Knit
import Foundation
import Testing
@testable import ExpandingWorld

@MainActor
struct AssemblySetupTests {
    
    @Test func testingSetup() {
        let assembler = ModuleAssembler([
            ExpandingWorldAssembly(),
            ASKCoreAssembly(purpose: .testing)
        ])
        
        #expect(assembler.resolver.iocPurpose() == .testing)
        #expect(assembler.resolver.pKeyValueStore() is InMemoryDefaults)
    }
    
    @Test func realSetup() {
        let assembler = ModuleAssembler([
            ExpandingWorldAssembly(),
            ASKCoreAssembly(purpose: .normal)
        ])
        
        #expect(assembler.resolver.iocPurpose() == .normal)
        #expect(assembler.resolver.pKeyValueStore() is UserDefaults)
    }
}
