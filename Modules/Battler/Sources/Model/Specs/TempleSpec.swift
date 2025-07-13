//  Created by Alexander Skorulis on 14/7/2025.

import Foundation

public enum TempleSpec: Sendable {
    case light
    case war
    
    var name: String {
        switch self {
        case .light:
            return "Temple of Light"
        case .war:
            return "Temple of War"
        }
    }
    
    var possibleBuffs: [TempleBuff] {
        switch self {
        case .light:
            return [
                .init(
                    buff: .init(name: "Holy Safety", effect: .defence(3), duration: .battles(1)),
                    cost: 5
                )
            ]
        case .war:
            return [
                .init(
                    buff: .init(name: "Fury", effect: .attack(3), duration: .battles(1)),
                    cost: 5
                )
            ]
        }
    }
}

extension TempleSpec {
    struct TempleBuff {
        let buff: Buff
        let cost: Int
    }
}
