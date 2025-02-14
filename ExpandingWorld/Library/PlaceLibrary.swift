//Created by Alexander Skorulis on 14/2/2025.

import Foundation

// The library of places that exist
final class PlaceLibrary {
    
    static var tavern1 = PlaceSpec(
        id: .pinkyTavern,
        name: "Pinky's Tavern",
        description: "A small Tavern with a questionable odor",
        features: [
            .init(
                id: .pinkyTavernBar,
                name: "Bar",
                description: "A wooden bar with a bartender behind it"
            )
        ]
    )
}
