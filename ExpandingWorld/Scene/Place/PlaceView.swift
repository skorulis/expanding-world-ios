//Created by Alexander Skorulis on 14/2/2025.

import Core
import Foundation
import Hex
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct PlaceView {
    @State var viewModel: PlaceViewModel
    @Environment(\.resolver) private var resolver
}

// MARK: - Rendering

extension PlaceView: View {
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            ZStack(alignment: .topLeading) {
                MapView(map: viewModel.currentMap) { coor in
                    print("Tap")
                }
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
            }
            
        }
    }
    
    private var old: some View {
        VStack {
            Text(viewModel.place.spec.name)
                .font(.title)
            ScrollView {
                VStack {
                    actions
                    Divider()
                    features
                }
            }
        }
        .sheet(item: $viewModel.shopID) { shopID in
            ShopView(viewModel: resolver!.shopViewModel(shopID: shopID))
        }
    }
    
    private var features: some View {
        VStack {
            ForEach(viewModel.visibleFeatures) { feature in
                PlaceFeatureView(feature: feature) { action in
                    viewModel.perform(action: action, feature: feature)
                }
                Divider()
            }
        }
    }
    
    private var actions: some View {
        HexagonGridLayout(hexSize: ActionButton.size / 2) {
            ForEach(viewModel.actions) { action in
                ActionButton(placeAction: action) {
                    viewModel.perform(action: action)
                }
            }
            ForEach(viewModel.transit) { transit in
                Button(action: { viewModel.changeLocation(id: transit.to.0, featureID: transit.to.1) }) {
                    VStack {
                        Image(systemName: "door.left.hand.closed")
                        Text("\(transit.text)")
                    }
                }
                .buttonStyle(HexagonButtonStyle())
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    let spec = PlaceLibrary.tavern1
    PlaceView(
        viewModel: assembler.resolver.placeViewModel(place: .init(spec: spec))
    )
}

