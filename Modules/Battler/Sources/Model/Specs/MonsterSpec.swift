//  Created by Alexander Skorulis on 10/5/2025.

import Foundation
import SwiftUI

public enum MonsterSpec: CaseIterable, Identifiable, Codable, Sendable {
    case rat
    case slime
    case angryCat
    
    var image: Image {
        switch self {
        case .rat:
            return Asset.Monsters.monsterRat.swiftUIImage
        case .slime:
            return Asset.Monsters.monsterSlime.swiftUIImage
        case .angryCat:
            return Asset.Monsters.angryCat.swiftUIImage
        }
    }
    
    var health: Int {
        switch self {
        case .rat:
            return 5
        case .slime:
            return 10
        case .angryCat:
            return 10
        }
    }
    
    var defence: Int {
        switch self {
        case .rat:
            return 3
        case .slime:
            return 1
        case .angryCat:
            return 4
        }
    }
    
    var attack: Int {
        switch self {
        case .rat:
            return 2
        case .slime:
            return 2
        case .angryCat:
            return 4
        }
    }
    
    var abilities: [AttackAbility] {
        switch self {
        case .rat:
            return [.unarmed(.bite, 1...3)]
        case .slime:
            return [.unarmed(.slap, 2...4)]
        case .angryCat:
            return [
                .monsterSkill(
                    nil,
                    .init(action: "Scratch", damage: 3...5, baseAttack: 1)
                )
            ]
        }
    }
    
    var name: String {
        switch self {
        case .rat: return "Rat"
        case .slime: return "Slime"
        case .angryCat: return "Angry cat"
        }
    }
    
    public var id: String { name }
    
    var difficultyValue: Int {
        switch self {
        case .rat:
            return 1
        case .slime, .angryCat:
            return 2
        }
    }
}

