//  Created by Alexander Skorulis on 12/7/2025.

import Foundation
import SwiftUI

@Observable final class TempleViewModel {
    var temple: Temple
    
    init(temple: Temple) {
        self.temple = temple
    }
    
}

// MARK: - Logic

extension TempleViewModel {
    
    func buy(item: Temple.BuffItem) {
        guard let index = (temple.buffs.firstIndex { $0.id == item.id }) else {
            return
        }
        var buff = temple.buffs[index]
        buff.count -= 1
        temple.buffs[index] = buff
    }
}
