//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

public struct BattlerFight: Sendable {
    
    let id = UUID()
    let startMonsters: [Monster]
    var monsters: [Monster]
    let difficulty: Int
    
    init(monsters: [MonsterSpec], difficulty: Int) {
        self.monsters = monsters.map { Monster(spec: $0) }
        self.startMonsters = self.monsters
        self.difficulty = difficulty
    }
    
    // The result of the battle
    public enum Result {
        case win, loss
    }
    
    var monsterDescriptions: String {
        let group = Dictionary(grouping: monsters, by: { $0.spec })
        return group.map { key, value in
            let plural = value.count != 1 ? "s" : ""
            return "\(value.count) \(key.name)\(plural)"
        }
        .joined(separator: ", ")
    }
    
    var reward: Int64 {
        let money = startMonsters.map { $0.spec.difficultyValue }.reduce(0, +) * startMonsters.count
        return Int64(money)
    }
}
