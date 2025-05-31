//  Created by Alexander Skorulis on 24/5/2025.

import Foundation

public enum Skill: String, Hashable, Codable, Sendable, CaseIterable, Identifiable {
    case unarmed
    case toughness
    case blades
    case melee
    
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
        }
    }
    
    public var canAutoLearn: Bool {
        switch self {
        case .blades, .toughness, .unarmed, .melee:
            return true
        }
    }
}
