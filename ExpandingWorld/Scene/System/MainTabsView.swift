//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MainTabsView {
    @Environment(\.resolver) private var resolver
}

// MARK: - Rendering

extension MainTabsView: View {
    
    var body: some View {
        TabView {
            placeTab
        }
    }
    
    var placeTab: some View {
        PlaceView(
            viewModel: resolver.placeViewModel(place: currentPlace)
        )
        .tabItem {
            Image(systemName: "map.fill")
        }
    }
    
    var currentPlace: Place {
        let spec = PlaceLibrary.tavern1
        return .init(spec: spec)
    }
}

// MARK: - Previews

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    MainTabsView()
        .environment(\.resolver, assembler.resolver)
}

