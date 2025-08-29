//  Created by Alexander Skorulis on 29/8/2025.

import Foundation
import Core

public extension SkillDictionary {
    
    var maxHealth: Int{
        return 10 + (max(value(.toughness), 1) - 1) * 5
    }
}
