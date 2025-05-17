//  Created by Alexander Skorulis on 26/4/2025.

import Foundation

public struct BattlerFight: Sendable {
    
    let id = UUID()
    var monsters: [Monster]
    
    init(monsters: [MonsterSpec]) {
        self.monsters = monsters.map { Monster(spec: $0) }
    }
    
    // The result of the battle
    public enum Result {
        case win, loss
    }
    
    public typealias ResultHandler = (Result) -> Void
    
    var monsterDescriptions: String {
        let group = Dictionary(grouping: monsters, by: { $0.spec })
        return group.map { key, value in
            let plural = value.count != 1 ? "s" : ""
            return "\(value.count) \(key.name)\(plural)"
        }
        .joined(separator: ", ")
        
    }
}
