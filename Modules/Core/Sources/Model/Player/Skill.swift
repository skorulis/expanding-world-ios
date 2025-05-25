//  Created by Alexander Skorulis on 24/5/2025.

import Foundation

public enum Skill: String, Hashable, Codable, Sendable, CaseIterable, Identifiable {
    case unarmed
    
    public var id: Self { self }
    
    public var name: String {
        switch self {
        case .unarmed:
            return "Unarmed fighting"
        }
    }
}
