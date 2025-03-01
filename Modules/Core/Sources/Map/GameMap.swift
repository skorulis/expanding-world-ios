//Created by Alexander Skorulis on 28/2/2025.

import Foundation
import SwiftUI

public struct GameMap: Codable {
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
    
    public subscript(position: Position) -> Tile {
        get {
            tiles[position.y][position.x]
        }
        set {
            tiles[position.y][position.x] = newValue
        }
    }
}

public extension GameMap {
    struct Position {
        public let x: Int
        public let y: Int
    }
    
    struct Tile: Codable {
        public var terrain: TerrainType?
        public var object: ObjectType?
        
        public init(terrain: TerrainType? = nil, object: ObjectType? = nil) {
            self.terrain = terrain
            self.object = object
        }
    }
    
    enum ObjectType: CaseIterable, Hashable, Codable {
        case brickBuiliding
        
        public var image: Image {
            switch self {
            case .brickBuiliding:
                return Asset.Objects.medivalPub.swiftUIImage
            }
        }
    }
    
    enum TerrainType: CaseIterable, Hashable, Codable {
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
