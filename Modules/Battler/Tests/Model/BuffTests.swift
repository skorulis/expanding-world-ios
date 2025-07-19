//  Created by Alexander Skorulis on 13/7/2025.

@testable import Battler
import Testing

struct BuffTests {
    
    @Test func durationAfterBattle() {
        #expect(EffectDuration.expired.updateAfterBattle() == .expired)
        #expect(EffectDuration.forever.updateAfterBattle() == .forever)
        #expect(EffectDuration.rounds(2).updateAfterBattle() == .expired)
        #expect(EffectDuration.battles(2).updateAfterBattle() == .battles(1))
        #expect(EffectDuration.battles(1).updateAfterBattle() == .expired)
    }
    
    @Test func duationAfterRound() {
        #expect(EffectDuration.expired.updateAfterRound() == .expired)
        #expect(EffectDuration.forever.updateAfterRound() == .forever)
        #expect(EffectDuration.rounds(2).updateAfterRound() == .rounds(1))
        #expect(EffectDuration.rounds(1).updateAfterRound() == .expired)
        #expect(EffectDuration.battles(2).updateAfterRound() == .battles(2))
    }
    
    @Test func durationIsExpired() {
        #expect(EffectDuration.expired.isExpired == true)
        #expect(EffectDuration.forever.isExpired == false)
        #expect(EffectDuration.rounds(2).isExpired == false)
        #expect(EffectDuration.battles(2).isExpired == false)
        #expect(EffectDuration.battles(0).isExpired == true)
        #expect(EffectDuration.rounds(0).isExpired == true)
    }
    
    @Test func buffsAfterBattle() {
        var buffs = Buffs(active: [.init(name: "", effect: .attack(2), duration: .battles(1))])
        #expect(buffs.active.count == 1)
        buffs.onBattleEnd()
        #expect(buffs.active.count == 0)
    }
    
    @Test func addBuff() {
        var buffs = Buffs()
        buffs.add(buff: .init(name: "", effect: .attack(1), duration: .forever))
        #expect(buffs.active.count == 1)
        buffs.add(buff: .init(name: "", effect: .attack(1), duration: .forever))
        #expect(buffs.active.count == 1)
        #expect(buffs.active[0] == StatusEffect(name: "", effect: .attack(2), duration: .forever))
        buffs.add(buff: .init(name: "", effect: .healing(1), duration: .forever))
        #expect(buffs.active.count == 2)
        buffs.add(buff: .init(name: "", effect: .attack(5), duration: .battles(1)))
        #expect(buffs.active.count == 3)
    }
}
