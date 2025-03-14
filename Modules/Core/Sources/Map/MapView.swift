//Created by Alexander Skorulis on 27/2/2025.

import Hex
import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct MapView {
    private let map: GameMap
    private let grid: HexagonGrid
    private let onCellTap: (GameMap.Position) -> Void
    
    public init(
        map: GameMap,
        onCellTap: @escaping (GameMap.Position) -> Void
    ) {
        self.map = map
        self.grid = map.grid
        self.onCellTap = onCellTap
    }
}

// MARK: - Rendering

extension MapView: View {
    
    public var body: some View {
        HexagonGridLayout(hexagon: grid.hexagon) {
            ForEach(0..<map.height, id: \.self) { y in
                ForEach(0..<map.width, id: \.self) { x in
                    tileView(x: x, y: y)
                }
            }
        }
        .frame(width: visualSize.width, height: visualSize.height)
    }
    
    @MainActor @ViewBuilder
    private func tileView(x: Int, y: Int) -> some View {
        let tile =  map.tiles[y][x]
        Button(action: { onCellTap(.init(x: x, y: y))}) {
            MapTileView(tile: map.tiles[y][x])
                .frame(width: 80, height: 68.5)
        }
        .buttonStyle(.plain)
    }
    
    private var visualSize: CGSize {
        grid.size(cellCount: map.width * map.height)
    }
}

// MARK: - Previews

#Preview {
    var map = GameMap(width: 8, height: 5, tiles: nil)
    map.tiles[2][2].terrain = .stone
    map.tiles[2][1].terrain = .stone
    map.tiles[1][1].terrain = .stone
    map.tiles[2][2].object = .brickBuiliding
    return MapView(map: map) { _ in }
}

