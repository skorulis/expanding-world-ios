//  Created by Alexander Skorulis on 13/7/2025.

import Foundation

struct Buff: Equatable {
    let type: BuffType
    var duration: BuffDuration
    
    func canCombine(_ other: Buff) -> Bool {
        return type.canCombine(other.type) && duration == other.duration
    }
    
    func combine(_ other: Buff) -> Buff {
        guard canCombine(other) else {
            fatalError("Attempt to combine incompatible buffs")
        }
        return .init(type: type.combine(other.type)!, duration: duration)
    }
}

enum BuffDuration: Equatable {
    /// The buff remains for x Battles
    case battles(Int)
    
    /// The buff remains for x rounds of a battle or until the battle ends
    case rounds(Int)
    
    /// The buff does not expire
    case forever
    
    /// This buff has expired and needs to be removed
    case expired
    
    func updateAfterBattle() -> BuffDuration {
        switch self {
        case .expired:
            return .expired
        case .forever:
            return .forever
        case .rounds:
            return .expired
        case let .battles(remaining):
            if remaining <= 1 {
                return .expired
            }
            return .battles(remaining - 1)
        }
    }
    
    func updateAfterRound() -> BuffDuration {
        switch self {
        case .expired:
            return .expired
        case .forever:
            return .forever
        case let .rounds(remaining):
            if remaining <= 1 {
                return .expired
            }
            return .rounds(remaining - 1)
        case .battles:
            return self
        }
    }
    
    var isExpired: Bool {
        switch self {
        case .expired:
            return true
        case .forever:
            return false
        case let .rounds(remaining):
            return remaining <= 0
        case let .battles(remaining):
            return remaining <= 0
        }
    }
}

enum BuffType: Equatable {
    /// Addition to ATK
    case attack(Int)
    
    /// Health restored at the end of the round
    case healing(Int)
    
    func canCombine(_ other: BuffType) -> Bool {
        return combine(other) != nil
    }
    
    func combine(_ other: BuffType) -> BuffType? {
        switch (self, other) {
        case let (.attack(v1), .attack(v2)):
            return .attack(v1 + v2)
        case let (.healing(v1), .healing(v2)):
            return .healing(v1 + v2)
        default:
            return nil
        }
    }
}
