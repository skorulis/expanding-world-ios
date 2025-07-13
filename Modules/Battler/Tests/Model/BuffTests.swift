//  Created by Alexander Skorulis on 13/7/2025.

@testable import Battler
import Testing

struct BuffTests {
    
    @Test func durationAfterBattle() {
        #expect(BuffDuration.expired.updateAfterBattle() == .expired)
        #expect(BuffDuration.forever.updateAfterBattle() == .forever)
        #expect(BuffDuration.rounds(2).updateAfterBattle() == .expired)
        #expect(BuffDuration.battles(2).updateAfterBattle() == .battles(1))
        #expect(BuffDuration.battles(1).updateAfterBattle() == .expired)
    }
    
    @Test func duationAfterRound() {
        #expect(BuffDuration.expired.updateAfterRound() == .expired)
        #expect(BuffDuration.forever.updateAfterRound() == .forever)
        #expect(BuffDuration.rounds(2).updateAfterRound() == .rounds(1))
        #expect(BuffDuration.rounds(1).updateAfterRound() == .expired)
        #expect(BuffDuration.battles(2).updateAfterRound() == .battles(2))
    }
    
    @Test func durationIsExpired() {
        #expect(BuffDuration.expired.isExpired == true)
        #expect(BuffDuration.forever.isExpired == false)
        #expect(BuffDuration.rounds(2).isExpired == false)
        #expect(BuffDuration.battles(2).isExpired == false)
        #expect(BuffDuration.battles(0).isExpired == true)
        #expect(BuffDuration.rounds(0).isExpired == true)
    }
    
    @Test func buffsAfterBattle() {
        var buffs = Buffs(active: [.init(type: .attack(2), duration: .battles(1))])
        #expect(buffs.active.count == 1)
        buffs.onBattleEnd()
        #expect(buffs.active.count == 0)
    }
    
    @Test func addBuff() {
        var buffs = Buffs()
        buffs.add(buff: .init(type: .attack(1), duration: .forever))
        #expect(buffs.active.count == 1)
        buffs.add(buff: .init(type: .attack(1), duration: .forever))
        #expect(buffs.active.count == 1)
        #expect(buffs.active[0] == Buff(type: .attack(2), duration: .forever))
        buffs.add(buff: .init(type: .healing(1), duration: .forever))
        #expect(buffs.active.count == 2)
        buffs.add(buff: .init(type: .attack(5), duration: .battles(1)))
        #expect(buffs.active.count == 3)
    }
}
