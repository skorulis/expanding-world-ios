//  Created by Alexander Skorulis on 4/5/2025.

@testable import Battler
import Foundation
import Testing

@MainActor
struct AttackExecutorTests {
    
    private let executor = AttackExecutor()
    
    @Test func attack1() {
        
        var c1: any Combatant = FakeCombatant()
        var c2: any Combatant = FakeCombatant()
        #expect(executor.execute(attacker: &c1, defender: &c2).eliminatedIDs.count == 0)
        #expect(c1.health.current == 10)
        #expect(c2.health.current == 5)
        #expect(executor.execute(attacker: &c1, defender: &c2).eliminatedIDs.count == 1)
        #expect(c1.health.current == 10)
        #expect(c2.health.current == 0)   
    }
    
    @Test func attackPower() {
        var c1 = BattlerPlayer()
        c1.skills.set(skill: .unarmed, value: 1)
        #expect(executor.attackValue(attacker: c1, ability: .unarmed(.punch, 1)) == 2)
        
        c1.skills.set(skill: .unarmed, value: 4)
        #expect(executor.attackValue(attacker: c1, ability: .unarmed(.punch, 1)) == 5)
    }
    
}

struct FakeCombatant: Combatant {
    let id: UUID = .init()
    var health: CombatantValue = .init(10)
    var abilities: [AttackAbility] { [.unarmed(.punch, 5)] }
}
