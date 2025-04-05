//Created by Alexander Skorulis on 16/3/2025.

import Foundation
import Core

final class MapLibrary {
    
    static func map(for place: PlaceID) -> GameMap {
        switch place {
        case .pinkyTavern:
            return pinkyTavern
        case .wharfRoad:
            return load(name: "wharfRoad")
        case .docks:
            return load(name: "docks")
        }
    }
    
    static var pinkyTavern: GameMap {
        return load(name: "map1")
    }
    
    private static func load(name: String) -> GameMap {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            fatalError("No map named: \(name)")
        }
        do {
            let data = try Data(contentsOf: url)
            var map = try JSONDecoder().decode(GameMap.self, from: data)
            map.updateFeatureConnections()
            return map
        } catch {
            fatalError("\(error)")
        }
        
    }
}
