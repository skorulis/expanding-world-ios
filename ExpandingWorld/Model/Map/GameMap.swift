//Created by Alexander Skorulis on 28/2/2025.

import Foundation
import SwiftUI

struct GameMap {
    let width: Int
    let height: Int
    var tiles: [[Tile]]
    
    init(width: Int, height: Int, tiles: [[Tile]]?) {
        self.width = width
        self.height = height
        self.tiles = tiles ?? Self.emptyTiles(width: width, height: height)
    }
    
    private static func emptyTiles(width: Int, height: Int) -> [[Tile]] {
        Array(repeating: Array(repeating: Tile(), count: width), count: height)
    }
}

extension GameMap {
    struct Tile {
        var terrain: TerrainType?
        var object: ObjectType?
    }
    
    enum ObjectType {
        case brickBuiliding
        
        var image: ImageAsset {
            switch self {
            case .brickBuiliding:
                return Asset.Objects.medivalPub
            }
        }
    }
    
    enum TerrainType {
        case dirt
        case grass
        case stone
        
        var image: ImageAsset {
            switch self {
            case .dirt:
                return Asset.dirt07
            case .grass:
                return Asset.grass05
            case .stone:
                return Asset.Terrain.stone02
            }
        }
        
    }
}
