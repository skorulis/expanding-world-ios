//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MainTabsView {
    
    @ObservedObject var knowledgeStore: KnowledgeStore
    
    @Environment(\.resolver) private var resolver
}

// MARK: - Rendering

extension MainTabsView: View {
    
    var body: some View {
        TabView {
            placeTab
            maybeInventory
            maybePlayerStatus
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
    
    @ViewBuilder
    var maybeInventory: some View {
        if knowledgeStore.gameFeatures.contains(.inventory) {
            PlayerInventoryView(
                viewModel: resolver.playerInventoryViewModel()
            )
            .tabItem {
                Image(systemName: "backpack.fill")
            }
        }
    }
    
    @ViewBuilder
    private var maybePlayerStatus: some View {
        if knowledgeStore.contains(any: GameFeature.playerStatuses) {
            PlayerStatusView(
                viewModel: resolver.playerStatusViewModel()
            )
            .tabItem {
                Image(systemName: "level.fill")
            }
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
    MainTabsView(knowledgeStore: assembler.resolver.knowledgeStore())
        .environment(\.resolver, assembler.resolver)
}

