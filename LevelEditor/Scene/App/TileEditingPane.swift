//Created by Alexander Skorulis on 1/3/2025.

import Core
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct TileEditingPane {
    let placeID: PlaceID?
    @Binding var tile: GameMap.Tile
}

// MARK: - Rendering

extension TileEditingPane: View {
    
    var body: some View {
        VStack {
            MapTileView(tile: tile)
                .frame(width: 80, height: 67)
            
            terrain
            object
            overlay
            maybeFeature
        }
        .frame(width: 220)
        .padding(.vertical, 20)
    }
    
    private var terrain: some View {
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
    }
    
    private var object: some View {
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
    
    @ViewBuilder
    private var maybeFeature: some View {
        if let placeID, !placeID.featureIDs.isEmpty {
            Picker(selection: $tile.featureID) {
                Text("None")
                    .tag(nil as PlaceFeatureID?)
                ForEach(placeID.featureIDs, id: \.self) { o in
                    Text("\(o)".capitalized)
                        .tag(o)
                }
            } label: {
                Text("featureID")
            }
            .pickerStyle(.menu)
        }
        
    }
    
    private var overlay: some View {
        Picker(selection: $tile.overlay) {
            Text("None")
                .tag(nil as GameMap.Overlay?)
            ForEach(GameMap.Overlay.allCases, id: \.self) { o in
                Text("\(o)".capitalized)
                    .tag(o)
            }
        } label: {
            Text("Overlay")
        }
        .pickerStyle(.menu)
    }
}

// MARK: - Previews

#Preview {
    @Previewable @State var tile = GameMap.Tile(terrain: .dirt)
    TileEditingPane(placeID: nil, tile: $tile)
}

