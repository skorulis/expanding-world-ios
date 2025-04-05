//  Created by Alexander Skorulis on 16/3/2025.

import Foundation

public enum PlaceID: Codable, CaseIterable, Hashable, Identifiable {
    case pinkyTavern
    case wharfRoad
    case docks
    
    public var id: Self { self }
    
    public var featureIDs: [PlaceFeatureID] {
        switch self {
        case .pinkyTavern:
            return [.pinkyTavernExit, .pinkyTavernBar, .pinkyTavernTables]
        case .wharfRoad:
            return [.wharfRoadTavernEntrance, .wharfRoadDockEntrance]
        case .docks:
            return []
        }
    }
}


public enum PlaceFeatureID: Codable, Hashable, Identifiable {
    // pinkyTavern
    case pinkyTavernExit
    case pinkyTavernBar
    case pinkyTavernTables
    
    // wharfRoad
    case wharfRoadTavernEntrance
    case wharfRoadDockEntrance
    
    // Docks
    case docksWharfRoad
    
    public var id: Self { self }
}
