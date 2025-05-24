//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

public struct BattlerFight: Sendable {
    
    let id = UUID()
    var monsters: [Monster]
    let difficulty: Int
    
    init(monsters: [MonsterSpec], difficulty: Int) {
        self.monsters = monsters.map { Monster(spec: $0) }
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
}
