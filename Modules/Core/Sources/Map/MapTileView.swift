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
        }
        .contentShape(HexagonShape())
    }
}

// MARK: - Previews

#Preview {
    VStack {
        MapTileView(tile: .init(terrain: .grass))
        MapTileView(tile: .init(terrain: .stoneFloor))
    }
    
}

