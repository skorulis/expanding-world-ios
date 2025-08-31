//  Created by Alexander Skorulis on 24/5/2025.

import Foundation

public enum Skill: String, Hashable, Codable, Sendable, CaseIterable, Identifiable {
    case unarmed
    case toughness
    case blades
    case melee
    case shield
    
    public var id: Self { self }
    
    public var name: String {
        switch self {
        case .unarmed:
            return "Unarmed fighting"
        case .toughness:
            return "Toughness"
        case .blades:
            return "Bladed weapons"
        case .melee:
            return "Melee fighting"
        case .shield:
            return "Shield"
        }
    }
    
    public var description: String {
        switch self {
        case .unarmed:
            return "Fighting without weapons"
        case .toughness:
            return "Being able to take a hit"
        case .blades:
            return "Fighting with sharp weapons"
        case .melee:
            return "Bonus to any close quarters fighting"
        case .shield:
            return "Skill in using a shield"
        }
    }
    
    public var canAutoLearn: Bool {
        switch self {
        case .toughness, .unarmed, .melee:
            return true
        default:
            return false
        }
    }
    
    public var purchaseCost: Int64 {
        switch self {
        case .unarmed, .toughness:
            return 0
        case .blades:
            return 25
        case .shield:
            return 25
        case .melee:
            return 50
        }
    }
    
    public func difficultyToXP(_ difficulty: Double) -> Double {
        switch self {
        case .toughness:
            return difficulty * 10
        default:
            // Standard scaling
            return pow(difficulty, 2) * 10
        }
    }
}
