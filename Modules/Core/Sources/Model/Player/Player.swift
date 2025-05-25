//Created by Alexander Skorulis on 16/2/2025.

import Core
import Hex
import Foundation

public struct Player: Codable {
    public var money: Int64
    public var inventory: Inventory
    public var statuses: Statuses
    public var location: Location
    public var deaths: Int
    public var skills: SkillDictionary
    
    public static var defaultValue: Player {
        .init(
            money: 100,
            inventory: .init(),
            statuses: .default,
            location: startingLocation,
            deaths: 0,
            skills: .init([.unarmed:1, .toughness: 1])
        )
    }
    
    public mutating func playerDied() {
        money = 100
        inventory = .init()
        statuses = .default
        location = Self.startingLocation
        deaths += 1
    }
    
    private static var startingLocation: Player.Location {
        return .init(place: .pinkyTavern, coord: .zero)
    }
}


extension Player {
    
    public struct Location: Codable {
        public let place: PlaceID
        public let coord: HexagonGrid.Coord
        
        public init(place: PlaceID, coord: HexagonGrid.Coord) {
            self.place = place
            self.coord = coord
        }
    }
    
    // TODO: Change name
    public enum Status: CaseIterable, Identifiable, Codable {
        case intoxication
        case satiation
        case health
        
        public var id: Self { self }
        
        public var normalisationRate: Float {
            switch self {
            case .health:
                return 0
            case .intoxication:
                return 1 / 3600
            case .satiation:
                return 0.5 / 3600
            }
        }
        
        public var text: String {
            switch self {
            case .intoxication:
                return "Intoxication"
            case .satiation:
                return "Satiation"
            case .health:
                return "Health"
            }
        }
        
        public var gameFeature: GameFeature {
            switch self {
            case .intoxication: return .intoxication
            case .satiation: return .satiation
            case .health: return .health
            }
        }
    }
    
    public struct Statuses: Codable {
        public var values: [Status: Float] = [:]
        
        public mutating func add(status: Status, amount: Int) {
            values[status] = (values[status] ?? 0) + Float(amount)
        }
        
        public func value(_ status: Status) -> Float {
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
