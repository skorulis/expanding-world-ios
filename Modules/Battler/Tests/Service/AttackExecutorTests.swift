//  Created by Alexander Skorulis on 4/5/2025.

import Foundation

@testable import Battler
import Testing

@MainActor
struct AttackExecutorTests {
    
    @Test func testAttack1() {
        let executor = AttackExecutor()
        var c1: any Combatant = FakeCombatant()
        var c2: any Combatant = FakeCombatant()
        #expect(executor.execute(attacker: &c1, defender: &c2).eliminatedIDs.count == 0)
        #expect(c1.health.current == 10)
        #expect(c2.health.current == 5)
        #expect(executor.execute(attacker: &c1, defender: &c2).eliminatedIDs.count == 1)
        #expect(c1.health.current == 10)
        #expect(c2.health.current == 0)   
    }
    
}

struct FakeCombatant: Combatant {
    let id: UUID = .init()
    var health: CombatantValue = .init(10)
    var abilities: [AttackAbility] { [.unarmed(.punch, 5)] }
}
