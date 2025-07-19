//  Created by Alexander Skorulis on 13/7/2025.

import Foundation

/// Container to hold Buff objects
struct Buffs {
    var active: [StatusEffect]
    
    init(active: [StatusEffect] = []) {
        self.active = active
    }
    
    /// Add a new active buff
    mutating func add(buff: StatusEffect) {
        if let combineIndex = (active.firstIndex { $0.canCombine(buff) }) {
            active[combineIndex] = active[combineIndex].combine(buff)
        } else {
            active.append(buff)
        }
    }
    
    /// Update durations after a battle ends
    mutating func onBattleEnd() {
        self.active = active.map { buff in
            var new = buff
            new.duration = buff.duration.updateAfterBattle()
            return new
        }
        .filter { !$0.duration.isExpired }
        
    }
    
    /// Update durations after a round ends
    mutating func onRoundEnd() {
        self.active = active.map { buff in
            var new = buff
            new.duration = buff.duration.updateAfterRound()
            return new
        }
        .filter { !$0.duration.isExpired }
    }
}
