//  Created by Alexander Skorulis on 4/5/2025.

import Foundation

struct AttackResult {
    let context: AttackContext
    let eliminatedIDs: Set<UUID>
}

struct AttackContext {
    var atk: Int?
    var def: Int?
    var hitChance: Double?
    var hitRoll: Double?
    var damage: Int?
    
    init(hitChance: Double? = nil, hitRoll: Double? = nil, damage: Int? = nil) {
        self.hitChance = hitChance
        self.hitRoll = hitRoll
        self.damage = damage
    }
    
    func logAttack() {
        if let atk {
            print("ATK: \(atk)")
        }
        if let def {
            print("DEF: \(def)")
        }
        
        if let hitChance, let hitRoll {
            print("HIT CHANCE: \(hitChance) / \(hitRoll)")
        }
        
        if let damage {
            print("DAMAGE: \(damage)")
        }
    }
    
}
