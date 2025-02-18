//Created by Alexander Skorulis on 18/2/2025.

import ASKCore
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct PlaceContainerView {
    @Environment(\.resolver) private var resolver
    
    @State var viewModel: PlaceContainerViewModel
}

// MARK: - Rendering

extension PlaceContainerView: View {
    
    var body: some View {
        PlaceView(viewModel: resolver.placeViewModel(place: currentPlace))
            .id(viewModel.playerStore.player.location)
    }
    
    var currentPlace: Place {
        let spec = PlaceLibrary.spec(for: viewModel.playerStore.player.location)
        return Place(spec: spec)
    }
}

// MARK: - Previews

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    PlaceContainerView(viewModel: assembler.resolver.placeContainerViewModel())
        .environment(\.resolver, assembler.resolver)
}

