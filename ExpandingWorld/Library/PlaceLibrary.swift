//Created by Alexander Skorulis on 14/2/2025.

import Foundation

// The library of places that exist
final class PlaceLibrary {
    
    static let wharfRoad = PlaceSpec(
        id: .wharfRoad,
        name: "Wharf Road",
        description: "A wide road heading east down towards the water and west upwards to the city where you can see the clock tower.",
        actions: [
            .look,
        ],
        transit: [
            .init(
                to: .pinkyTavern,
                text: "Pinky's"
            ),
            .init(to: .docks, text: "Docks")
        ],
        features: []
    )
    
    static let tavern1 = PlaceSpec(
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
                    .shop(.pinkyTavern),
                    .work(4 * 3600, .fixed([
                        .alert("You make X waiting tables")
                    ]))
                ]
            ),
            .init(
                id: .pinkyTavernTables,
                name: "Tables",
                description: "A collection of tables each seating 4 patrons",
                actions: [
                    .talk(
                        .init(
                            conditionals: [
                                .init(
                                    condition: { Player.Status.intoxication.v >= 4.c },
                                    outcomes: [
                                        .alert("Yes"),
                                        .time(600),
                                    ])
                            ],
                            fallback: [
                                .alert("Nobody seems interested in talking to you. They glance in your direction and return to their drunken conversations"),
                                .time(120),
                            ]
                        )
                    )
                ]
            )
        ]
    )
    
    static let docks = PlaceSpec(
        id: .docks,
        name: "The Docks",
        description: "A number of wooden jetties jut out into the bay. Ships of various sizes are docked and goods are being loaded and unloaded.",
        actions: [
            .look,
        ],
        transit: [.init(to: .wharfRoad, text: "Wharf Road")],
        features: []
    )
    
    static func spec(for id: PlaceID) -> PlaceSpec {
        switch id {
        case .pinkyTavern: return tavern1
        case .wharfRoad: return wharfRoad
        case .docks: return docks
        }
    }
}
