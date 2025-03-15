//Created by Alexander Skorulis on 28/2/2025.

import Hex
import Foundation
import SwiftUI

public struct GameMap: Codable {
    
    public static let hexWidth: CGFloat = 80
    
    public var width: Int {
        didSet {
            widthChanged()
        }
    }
    
    public var height: Int {
        didSet {
            heightChanged()
        }
    }
    public var tiles: [[Tile]]
    
    public init(width: Int, height: Int, tiles: [[Tile]]?) {
        self.width = width
        self.height = height
        self.tiles = tiles ?? Self.emptyTiles(width: width, height: height)
        updateFeatureConnections()
    }
    
    private static func emptyTiles(width: Int, height: Int) -> [[Tile]] {
        Array(repeating: Array(repeating: Tile(), count: width), count: height)
    }
    
    public subscript(position: HexagonGrid.Coord) -> Tile {
        get {
            tiles[position.y][position.x]
        }
        set {
            tiles[position.y][position.x] = newValue
        }
    }
    
    private mutating func widthChanged() {
        while width < tiles[0].count {
            tiles = tiles.map { $0.dropLast() }
        }
        while width > tiles[0].count {
            tiles = tiles.map { $0 + [Tile()] }
        }
    }
    
    private mutating func heightChanged() {
        while height < tiles.count {
            _ = tiles.removeLast()
        }
        while height > tiles.count {
            _ = tiles.append(Array(repeating: Tile(), count: width))
        }
    }
    
    public mutating func updateFeatureConnections() {
        for y in 0..<height {
            for x in 0..<width {
                updateFeatureConnections(coord: .init(x: x, y: y))
            }
        }
    }
    
    public mutating func updateFeatureConnections(coord: HexagonGrid.Coord) {
        var tile = tiles[coord.y][coord.x]
        guard let feature = tile.feature else {
            tile.wallEdges = []
            tiles[coord.y][coord.x] = tile
            return
        }
        tile.wallEdges = HexagonEdge.allCases.filter { edge in
            let pos = coord.move(dir: edge)
            guard contains(coord: pos) else { return false }
            return self[pos].feature == feature
        }
        tiles[coord.y][coord.x] = tile
    }
    
    public func contains(coord: HexagonGrid.Coord) -> Bool {
        return coord.x >= 0 && coord.x < width && coord.y >= 0 && coord.y < height
    }
}

public extension GameMap {
    
    struct Tile: Codable {
        public var terrain: TerrainType?
        public var object: ObjectType?
        public var feature: Feature?
        
        public init(
            terrain: TerrainType? = nil,
            object: ObjectType? = nil,
            feature: Feature? = nil
        ) {
            self.terrain = terrain
            self.object = object
            self.feature = feature
        }
        
        private enum CodingKeys: String, CodingKey {
            case terrain, object, feature
        }
        
        /// Cache for the positions of the wall
        public var wallEdges: [HexagonEdge] = []
    }
    
    enum Feature: CaseIterable, Hashable, Codable {
        case wall
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
        case stoneFloor
        case woodFloor
        
        public var image: Image {
            switch self {
            case .dirt:
                return Asset.Terrain.dirt07.swiftUIImage
            case .grass:
                return Asset.Terrain.grass05.swiftUIImage
            case .stone:
                return Asset.Terrain.stone02.swiftUIImage
            case .stoneFloor:
                return Asset.Terrain.stoneFloor.swiftUIImage
            case .woodFloor:
                return Asset.Terrain.woodTexture.swiftUIImage
            }
        }
        
    }
}

extension GameMap {
    public var grid: HexagonGrid {
        HexagonGrid(hexagon: .init(width: Self.hexWidth), columns: width, rows: height)
    }
}
