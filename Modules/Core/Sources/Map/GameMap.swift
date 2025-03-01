//Created by Alexander Skorulis on 28/2/2025.

import Foundation
import SwiftUI

public struct GameMap {
    public let width: Int
    public let height: Int
    public var tiles: [[Tile]]
    
    public init(width: Int, height: Int, tiles: [[Tile]]?) {
        self.width = width
        self.height = height
        self.tiles = tiles ?? Self.emptyTiles(width: width, height: height)
    }
    
    private static func emptyTiles(width: Int, height: Int) -> [[Tile]] {
        Array(repeating: Array(repeating: Tile(), count: width), count: height)
    }
}

public extension GameMap {
    struct Tile {
        public var terrain: TerrainType?
        public var object: ObjectType?
    }
    
    enum ObjectType {
        case brickBuiliding
        
        public var image: Image {
            switch self {
            case .brickBuiliding:
                return Asset.Objects.medivalPub.swiftUIImage
            }
        }
    }
    
    enum TerrainType {
        case dirt
        case grass
        case stone
        
        public var image: Image {
            switch self {
            case .dirt:
                return Asset.Terrain.dirt07.swiftUIImage
            case .grass:
                return Asset.Terrain.grass05.swiftUIImage
            case .stone:
                return Asset.Terrain.stone02.swiftUIImage
            }
        }
        
    }
}
