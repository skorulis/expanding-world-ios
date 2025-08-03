//  Created by Alexander Skorulis on 3/8/2025.

import Core
@testable import Battler
import Testing

struct BatlerPlayerTests {
    
    @Test func activeStatusEffects() {
        let skills = SkillDictionary([.unarmed: 3])
        var player = BattlerPlayer(money: 0, skills: skills)
        
        #expect(player.activeSkillEffects().count == 2)
        
        player.inventory.add(.init(type: .copperDagger, amount: 1))
        player.inventory.equip(.copperDagger, .mainHand)
        #expect(player.activeSkillEffects().count == 0)
    }
    
}
