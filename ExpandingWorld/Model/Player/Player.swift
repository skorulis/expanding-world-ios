//Created by Alexander Skorulis on 16/2/2025.

import Foundation

struct Player: Codable {
    var money: Int64
    var inventory: Inventory
    var statuses: Statuses
    var location: PlaceID
    
    static var defaultValue: Player {
        .init(money: 100, inventory: .init(), statuses: .default, location: .pinkyTavern)
    }
}

extension Player: DataStorable {
    static var storageKey: DataStoreKey { .player }
}

extension Player {
    
    // TODO: Change name
    enum Status: CaseIterable, Identifiable, Codable {
        case intoxication
        case satiation
        
        var id: Self { self }
        
        var normalisationRate: Float {
            switch self {
            case .intoxication:
                return 1 / 3600
            case .satiation:
                return 0.5 / 3600
            }
        }
        
        var text: String {
            switch self {
            case .intoxication:
                return "Intoxication"
            case .satiation:
                return "Satiation"
            }
        }
        
        var gameFeature: GameFeature {
            switch self {
            case .intoxication: return .intoxication
            case .satiation: return .satiation
            }
        }
    }
    
    struct Statuses: Codable {
        var values: [Status: Float] = [:]
        
        mutating func add(status: Status, amount: Int) {
            values[status] = (values[status] ?? 0) + Float(amount)
        }
        
        func value(_ status: Status) -> Float {
            values[status] ?? 0
        }
        
        static var `default`: Statuses {
            .init(values: [.satiation: 10])
        }
        
        var intoxication: Float {
            values[.intoxication] ?? 0
        }
        
        var satiation: Float {
            values[.satiation] ?? 0
        }
    }
}
