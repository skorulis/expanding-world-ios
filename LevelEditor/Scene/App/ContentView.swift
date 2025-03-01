//Created by Alexander Skorulis on 1/3/2025.

import Core
import SwiftUI

struct ContentView: View {
    
    @State private var map = GameMap(width: 10, height: 10, tiles: nil)
    @State private var selected: GameMap.Position?
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ScrollView([.horizontal, .vertical]) {
                MapView(map: map) { pos in
                    selected = pos
                }
                .gesture(gesture)
                .simultaneousGesture(gesture)
            }
            editingPane
        }
    }
    
    private let gesture = DragGesture()
        .onChanged { x in
            print("Drag: \(x)")
        }
    
    @ViewBuilder
    private var editingPane: some View {
        VStack {
            
            if let selected {
                TileEditingPane(tile: tileBinding(selected))
            }
        }
    }
    
    private func tileBinding(_ position: GameMap.Position) -> Binding<GameMap.Tile> {
        .init {
            map[position]
        } set: { newValue in
            map[position] = newValue
        }

    }
}

#Preview {
    ContentView()
}
