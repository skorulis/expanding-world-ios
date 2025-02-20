//Created by Alexander Skorulis on 15/2/2025.

import Foundation

enum GameFeature: Identifiable, Codable {
    case money
    case time
    case inventory
    case satiation
    case intoxication
    
    static var playerStatuses: [GameFeature] {
        return Player.Status.allCases.map { $0.gameFeature }
    }
    
    var discoveryText: String {
        switch self {
        case .money:
            return "You reach into your pocket to see what money you have to pay with"
        case .time:
            return "What time is it?"
        case .inventory:
            return "I guess I'll put this in my pocket"
        case .satiation:
            return "You're beginning to feel hungry"
        case .intoxication:
            return "Those drinks are really starting to go to your head"
        }
    }
    
    var id: Self { self }
}
