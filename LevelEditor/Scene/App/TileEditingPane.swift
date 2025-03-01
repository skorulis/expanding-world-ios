//Created by Alexander Skorulis on 1/3/2025.

import Core
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct TileEditingPane {
    @Binding var tile: GameMap.Tile
}

// MARK: - Rendering

extension TileEditingPane: View {
    
    var body: some View {
        VStack {
            MapTileView(tile: tile)
                .frame(width: 80, height: 67)
            
            Picker(selection: $tile.terrain) {
                Text("None")
                    .tag(nil as GameMap.TerrainType?)
                ForEach(GameMap.TerrainType.allCases, id: \.self) { t in
                    Text("\(t)".capitalized)
                        .tag(t)
                }
            } label: {
                Text("Terrain")
            }
            .pickerStyle(.menu)
            
            Picker(selection: $tile.object) {
                Text("None")
                    .tag(nil as GameMap.ObjectType?)
                ForEach(GameMap.ObjectType.allCases, id: \.self) { o in
                    Text("\(o)".capitalized)
                        .tag(o)
                }
            } label: {
                Text("Object")
            }
            .pickerStyle(.menu)
        }
        .frame(width: 220)
        .padding(.vertical, 20)
    }
}

// MARK: - Previews

#Preview {
    @Previewable @State var tile = GameMap.Tile(terrain: .dirt)
    TileEditingPane(tile: $tile)
}

