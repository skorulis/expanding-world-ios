//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct PlaceView {
    @State var viewModel: PlaceViewModel
}

// MARK: - Rendering

extension PlaceView: View {
    
    var body: some View {
        VStack {
            Text(viewModel.place.spec.name)
                .font(.title)
            ScrollView {
                VStack {
                    features
                    actions
                }
            }
        }
    }
    
    private var features: some View {
        VStack {
            ForEach(viewModel.visibleFeatures) { feature in
                PlaceFeatureView(feature: feature)
            }
        }
    }
    
    private var actions: some View {
        VStack {
            ForEach(viewModel.actions) { action in
                Button(action: { viewModel.perform(action: action) }) {
                    Text(action.text)
                }
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

