//  Created by Alexander Skorulis on 25/5/2025.

import Foundation

final class FixedRandomNumberGenerator: RandomNumberGenerator {
    
    var testValue: UInt64 = UInt64.max
    
    func next() -> UInt64 {
        testValue
    }
    
}
