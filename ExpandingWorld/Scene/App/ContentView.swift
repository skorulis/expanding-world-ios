//  Created by Alexander Skorulis on 14/2/2025.

import SwiftUI

struct ContentView: View {
    
    @State var viewModel: ContentViewModel
    @Environment(\.resolver) private var resolver
    
    var body: some View {
        PlaceView(
            viewModel: resolver.placeViewModel(place: viewModel.currentPlace)
        )
        .overlay(maybeAlert)
    }
    
    @ViewBuilder
    private var maybeAlert: some View {
        if let alert = viewModel.currentAlert {
            AlertView(
                alert: alert,
                onAction: viewModel.alertService.close
            )
        }
    }
}

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    ContentView(viewModel: assembler.resolver.contentViewModel())
}
