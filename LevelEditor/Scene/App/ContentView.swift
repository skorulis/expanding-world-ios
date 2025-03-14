//Created by Alexander Skorulis on 1/3/2025.

import Core
import Hex
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
            sharedPain
                .frame(width: 240)
        }
    }
    
    private var gesture: some Gesture {
        DragGesture()
            .onChanged { state in
                if let coord = viewModel.grid.coordinate(point: state.location) {
                    viewModel.maybePaint(coord: coord)
                }
            }
    }
    
    private var paintPane: some View {
        VStack {
            Picker(selection: $viewModel.paintTexture) {
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
    }
    
    private var sharedPain: some View {
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
            
            Picker(selection: $viewModel.mode) {
                ForEach(ContentViewModel.EditMode.allCases) { t in
                    Text("\(String(describing: t))")
                        .tag(t)
                }
            } label: {
                Text("Edit Mode")
            }
            .pickerStyle(.segmented)
            switch viewModel.mode {
            case .paint:
                paintPane
            case .single:
                editingPane
            }
        }
    }
    
    @ViewBuilder
    private var editingPane: some View {
        VStack {
            
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
