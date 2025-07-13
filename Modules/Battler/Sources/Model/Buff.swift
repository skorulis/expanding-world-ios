//  Created by Alexander Skorulis on 13/7/2025.

import Foundation

struct Buff: Equatable {
    let name: String
    let effect: BuffEffect
    var duration: BuffDuration
    
    func canCombine(_ other: Buff) -> Bool {
        return name == other.name && effect.canCombine(other.effect) && duration == other.duration
    }
    
    func combine(_ other: Buff) -> Buff {
        guard canCombine(other) else {
            fatalError("Attempt to combine incompatible buffs")
        }
        return .init(name: name, effect: effect.combine(other.effect)!, duration: duration)
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
    
    var description: String {
        switch self {
        case .expired:
            return "Expired"
        case .forever:
            return "Forever"
        case let .rounds(int):
            if int == 1 {
                return "1 round"
            }
            return "\(int) rounds"
        case let .battles(int):
            if int == 1 {
                return "1 battle"
            }
            return "\(int) battles"
        }
    }
}

enum BuffEffect: Equatable {
    /// Addition to ATK
    case attack(Int)
    
    /// Addition to DEF
    case defence(Int)
    
    /// Health restored at the end of the round
    case healing(Int)
    
    func canCombine(_ other: BuffEffect) -> Bool {
        return combine(other) != nil
    }
    
    func combine(_ other: BuffEffect) -> BuffEffect? {
        switch (self, other) {
        case let (.attack(v1), .attack(v2)):
            return .attack(v1 + v2)
        case let (.defence(v1), .defence(v2)):
            return .defence(v1 + v2)
        case let (.healing(v1), .healing(v2)):
            return .healing(v1 + v2)
        default:
            return nil
        }
    }
    
    var description: String {
        switch self {
        case let .attack(int):
            return "Attack +\(int)"
        case let .defence(int):
            return "Defence +\(int)"
        case let .healing(int):
            return "Heal \(int)HP each round"
        }
    }
}
