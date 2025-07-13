//  Created by Alexander Skorulis on 12/7/2025.

import Foundation

public struct Temple: Sendable {
    
    let spec: TempleSpec
    var buffs: [BuffItem]
    
    init(spec: TempleSpec) {
        self.spec = spec
        self.buffs = spec.possibleBuffs.map { buff in
            BuffItem(buff: buff.buff, cost: buff.cost, count: 1)
        }
    }
    
    var name: String { spec.name }
}

extension Temple {
    struct BuffItem: Identifiable {
        let id: UUID = .init()
        let buff: Buff
        let cost: Int
        var count: Int
    }
}
