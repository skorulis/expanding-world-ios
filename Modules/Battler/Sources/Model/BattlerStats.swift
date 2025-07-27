//  Created by Alexander Skorulis on 1/6/2025.

import Foundation

struct BattlerStats: Codable {
    var killCounts: [MonsterSpec: Int]
    var gameStarts: Int
    var moneyEarned: Int64 = 0
    var fightsWon: Int = 0
    var damageDealt: Int = 0
    var damageTaken: Int = 0
    
    static var defaultValue: BattlerStats {
        .init(
            killCounts: [:],
            gameStarts: 0,
            moneyEarned: 0,
            fightsWon: 0,
            damageDealt: 0,
            damageTaken: 0
        )
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
