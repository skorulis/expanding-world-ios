//Created by Alexander Skorulis on 15/2/2025.

import Core
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
            settings
        }
    }
    
    var placeTab: some View {
        PlaceContainerView(viewModel: resolver!.placeContainerViewModel())
            .tabItem {
                Image(systemName: "map.fill")
            }
    }
    
    @ViewBuilder
    var maybeInventory: some View {
        if knowledgeStore.knowledge.gameFeatures.contains(.inventory) {
            PlayerInventoryView(
                viewModel: resolver!.playerInventoryViewModel()
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
                viewModel: resolver!.playerStatusViewModel()
            )
            .tabItem {
                Image(systemName: "level.fill")
            }
        }
    }
    
    @ViewBuilder
    private var settings: some View {
        SettingsView(viewModel: resolver!.settingsViewModel())
            .tabItem {
                Image(systemName: "gearshape.fill")
            }
    }
    
}

// MARK: - Previews

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    MainTabsView(knowledgeStore: assembler.resolver.knowledgeStore())
        .environment(\.resolver, assembler.resolver)
}

