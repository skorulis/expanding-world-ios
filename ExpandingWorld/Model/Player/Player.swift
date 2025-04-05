//Created by Alexander Skorulis on 16/2/2025.

import Core
import Hex
import Foundation

struct Player: Codable {
    var money: Int64
    var inventory: Inventory
    var statuses: Statuses
    var location: Location
    var deaths: Int
    
    static var defaultValue: Player {
        .init(
            money: 100,
            inventory: .init(),
            statuses: .default,
            location: startingLocation,
            deaths: 0
        )
    }
    
    mutating func playerDied() {
        money = 100
        inventory = .init()
        statuses = .default
        location = Self.startingLocation
        deaths += 1
    }
    
    private static var startingLocation: Player.Location {
        let coord = MapLibrary.pinkyTavern.coordinate(feature: .pinkyTavernExit)!
        return .init(place: .pinkyTavern, coord: coord)
    }
}

extension Player: DataStorable {
    static var storageKey: DataStoreKey { .player }
}

extension Player {
    
    struct Location: Codable {
        let place: PlaceID
        let coord: HexagonGrid.Coord
    }
    
    // TODO: Change name
    enum Status: CaseIterable, Identifiable, Codable {
        case intoxication
        case satiation
        case health
        
        var id: Self { self }
        
        var normalisationRate: Float {
            switch self {
            case .health:
                return 0
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
            case .health:
                return "Health"
            }
        }
        
        var gameFeature: GameFeature {
            switch self {
            case .intoxication: return .intoxication
            case .satiation: return .satiation
            case .health: return .health
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
            .init(values: [.satiation: 10, .health: 10])
        }
        
        var intoxication: Float {
            values[.intoxication] ?? 0
        }
        
        var satiation: Float {
            values[.satiation] ?? 0
        }
    }
}
