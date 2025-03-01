//Created by Alexander Skorulis on 1/3/2025.

import Core
import SwiftUI

struct ContentView: View {
    
    @State var viewModel = ContentViewModel()
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ScrollView([.horizontal, .vertical]) {
                MapView(map: viewModel.map) { pos in
                    viewModel.selected = pos
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
            HStack {
                Button(action: viewModel.openFile) {
                    Text("Load")
                }
                
                Button(action: viewModel.saveMap) {
                    Text("Save")
                }
            }
            Stepper("Width: \(viewModel.map.width)", value: $viewModel.map.width, in: 1...100)
            Stepper("Height: \(viewModel.map.height)", value: $viewModel.map.height, in: 1...100)
            
            if let selected = viewModel.selected {
                TileEditingPane(tile: tileBinding(selected))
            }
        }
    }
    
    private func tileBinding(_ position: GameMap.Position) -> Binding<GameMap.Tile> {
        .init {
            viewModel.map[position]
        } set: { newValue in
            viewModel.map[position] = newValue
        }

    }
}

#Preview {
    ContentView()
}
