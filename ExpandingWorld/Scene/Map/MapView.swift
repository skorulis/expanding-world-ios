//Created by Alexander Skorulis on 27/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MapView {
    private let map: GameMap
    private let math: HexagonMath
    
    init(map: GameMap) {
        self.map = map
        self.math = HexagonMath(width: 80)
    }
}

// MARK: - Rendering

extension MapView: View {
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            HexagonGrid(hexSize: 40) {
                ForEach(0..<map.height, id: \.self) { y in
                    ForEach(0..<map.width, id: \.self) { x in
                        tileView(x: x, y: y)
                            .frame(width: 80, height: 68.5)
                    }
                }
            }
            .frame(width: visualSize.width, height: visualSize.height)
        }
    }
    
    @ViewBuilder
    private func tileView(x: Int, y: Int) -> some View {
        let tile = map.tiles[y][x]
        ZStack {
            if let terrain = tile.terrain {
                terrain.image.swiftUIImage
                    .resizable()
            } else {
                HexagonShape()
                    .stroke(Color.gray)
            }
            if let object = tile.object {
                object.image.swiftUIImage
                    .resizable()
                    .frame(width: 60, height: 60)
            }
            
        }
    }
    
    private var visualSize: CGSize {
        math.size(cols: map.width, rows: map.height, cellCount: map.width * map.height)
    }
}

// MARK: - Previews

#Preview {
    var map = GameMap(width: 8, height: 5, tiles: nil)
    map.tiles[2][2].terrain = .stone
    map.tiles[2][1].terrain = .stone
    map.tiles[1][1].terrain = .stone
    map.tiles[2][2].object = .brickBuiliding
    return MapView(map: map)
}

