//  Created by Alexander Skorulis on 10/5/2025.

import Foundation
import SwiftUI

enum MonsterSpec: CaseIterable, Identifiable, Codable {
    case rat
    case slime
    
    var image: Image {
        switch self {
        case .rat:
            return Asset.Monsters.monsterRat.swiftUIImage
        case .slime:
            return Asset.Monsters.monsterSlime.swiftUIImage
        }
    }
    
    var health: Int {
        switch self {
        case .rat:
            return 5
        case .slime:
            return 10
        }
    }
    
    var abilities: [AttackAbility] {
        switch self {
        case .rat:
            return [.unarmed(.bite, 1...3)]
        case .slime:
            return [.unarmed(.slap, 2...4)]
        }
    }
    
    var name: String {
        switch self {
        case .rat: return "Rat"
        case .slime: return "Slime"
        }
    }
    
    var id: String { name }
    
    var difficultyValue: Int {
        switch self {
        case .rat:
            return 1
        case .slime:
            return 2
        }
    }
}

