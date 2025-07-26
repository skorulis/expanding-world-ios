//  Created by Alexander Skorulis on 1/6/2025.

import Foundation

struct BattlerStats: Codable {
    var killCounts: [MonsterSpec: Int]
    var gameStarts: Int
    
    static var defaultValue: BattlerStats {
        .init(killCounts: [:], gameStarts: 0)
    }
    
    mutating func addKill(spec: MonsterSpec) {
        killCounts[spec] = (killCounts[spec] ?? 0) + 1
    }
    
    func kills(spec: MonsterSpec) -> Int {
        killCounts[spec] ?? 0
    }
    
    var totalKills: Int {
        killCounts.reduce(0) { $0 + $1.value }
    }
}
