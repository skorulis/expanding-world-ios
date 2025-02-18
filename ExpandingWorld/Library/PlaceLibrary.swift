//Created by Alexander Skorulis on 14/2/2025.

import Foundation

// The library of places that exist
final class PlaceLibrary {
    
    static var wharfRoad = PlaceSpec(
        id: .wharfRoad,
        name: "Wharf Road",
        description: "A road between the wharf",
        actions: [],
        transit: [
            .init(
                to: .pinkyTavern,
                text: "Pinky's"
            )
        ],
        features: []
    )
    
    static var tavern1 = PlaceSpec(
        id: .pinkyTavern,
        name: "Pinky's Tavern",
        description: "A small tavern with a questionable odor. There is a bar towards the back of the room and assorted tables",
        actions: [
            .look,
        ],
        transit: [
            .init(
                to: .wharfRoad,
                text: "Exit"
            )
        ],
        features: [
            .init(
                id: .pinkyTavernBar,
                name: "Bar",
                description: "There is an short grizzled bartender behind the bar and a sign above the bar reads \"Pinky's Tavern 24/7\"",
                actions: [
                    .look,
                    .shop(.pinkyTavern),
                ]
            ),
            .init(
                id: .pinkyTavernTables,
                name: "Tables",
                description: "A collection of tables each seating 4 patrons",
                actions: [
                    .look,
                ]
            ),
            .init(
                id: .pinkyTavernExit,
                name: "Exit",
                description: "A door out into the street",
                actions: [
                    .look,
                ]
            )
        ]
    )
    
    static func spec(for id: PlaceID) -> PlaceSpec {
        switch id {
        case .pinkyTavern:
            return tavern1
        case .wharfRoad:
            return wharfRoad
        }
    }
}
