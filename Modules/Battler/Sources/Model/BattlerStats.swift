//  Created by Alexander Skorulis on 1/6/2025.

import Foundation

struct BattlerStats: Codable {
    var killCounts: [MonsterSpec: Int]
    
    mutating func addKill(spec: MonsterSpec) {
        killCounts[spec] = (killCounts[spec] ?? 0) + 1
    }
    
    func kills(spec: MonsterSpec) -> Int {
        killCounts[spec] ?? 0
    }
}
