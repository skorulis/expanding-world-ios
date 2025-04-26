//  Created by Alexander Skorulis on 1/3/2025.

import Foundation
import Hex
import SwiftUI

// MARK: - Memory footprint

public struct MapTileView {
    private let tile: GameMap.Tile
    
    public init(tile: GameMap.Tile) {
        self.tile = tile
    }
}

// MARK: - Rendering

extension MapTileView: View {
    
    public var body: some View {
        ZStack {
            if let terrain = tile.terrain {
                terrain.image
                    .resizable()
                    .clipShape(HexagonShape())
            } else {
                HexagonShape()
                    .stroke(Color.gray)
            }
            if let object = tile.object {
                object.image
                    .resizable()
                    .frame(width: 60, height: 60)
            }
            if !tile.wallEdges.isEmpty {
                WallShape(edges: tile.wallEdges)
                    .fill(Color.gray)
            }
            if let featureID = tile.featureID {
                featureID.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }
        }
        .contentShape(HexagonShape())
    }
}

extension PlaceFeatureID {
    var image: Image {
        switch self {
        case .pinkyTavernExit:
            Image(systemName: "door.left.hand.closed")
        case .pinkyTavernBar:
            Image(systemName: "wineglass.fill")
        case .pinkyTavernTables:
            Image(systemName: "table.furniture.fill")
        case .wharfRoadTavernEntrance:
            Image(systemName: "door.left.hand.closed")
        case .wharfRoadDockEntrance:
            Image(systemName: "door.left.hand.closed")
        case .docksWharfRoad:
            Image(systemName: "road.lanes.curved.left")
        }
    }
}

// MARK: - Previews

#Preview {
    VStack {
        MapTileView(tile: .init(terrain: .grass))
        MapTileView(tile: .init(terrain: .stoneFloor))
        MapTileView(tile: .init(terrain: .stoneFloor, overlay: .wall))
    }
    .frame(width: 80)
    
}

