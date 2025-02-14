//Created by Alexander Skorulis on 14/2/2025.

import Foundation

final class TimeStore {
    private(set) var seconds: Int64 = 0
    
    func advance(seconds: Int64) {
        self.seconds += seconds
    }
}
