//  Created by Alexander Skorulis on 4/5/2025.

import Foundation
import SwiftUI

enum AttackAbility {
    case unarmed(UnarmedType, Int)

    var image: Image {
        switch self {
        case let .unarmed(type, _):
            return type.image
        }
    }

    var name: String {
        switch self {
        case let .unarmed(type, _):
            return type.name
        }
    }

}

extension AttackAbility {
    enum UnarmedType {
        case punch
        case kick
        case bite
        
        var image: Image {
            switch self {
            case .punch:
                return Image(systemName: "figure.boxing")
            case .kick:
                return Image(systemName: "figure.kickboxing")
            case .bite:
                return Image(systemName: "mouth.fill")
            }
        }
        
        var name: String {
            switch self {
            case .punch:
                return "Punch"
            case .kick:
                return "Kick"
            case .bite:
                return "Bite"
            }
        }
    }
}
