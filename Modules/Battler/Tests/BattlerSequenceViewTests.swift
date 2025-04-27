//  Created by Alexander Skorulis on 26/4/2025.

@testable import Battler
import Knit
import Testing

@MainActor
struct BattlerSequenceViewTests {
    
    @Test func example() {
        let assembler = BattlerAssembly.testing()
        let resolver = assembler.resolver as! Resolver
        print(resolver)
    }
}
