//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct PlayerStatusView {
    @State var viewModel: PlayerStatusViewModel
}

// MARK: - Rendering

extension PlayerStatusView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Player.Status.allCases) { status in
                    maybeRow(status)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private func maybeRow(_ status: Player.Status) -> some View {
        if viewModel.knowledgeStore.gameFeatures.contains(status.gameFeature) {
            VStack(alignment: .leading, spacing: 0) {
                Text(status.text)
                StatusBar(value: 5, max: 10)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    let knowledgeStore = assembler.resolver.knowledgeStore()
    knowledgeStore.learn(game: .satiation)
    return PlayerStatusView(
        viewModel: assembler.resolver.playerStatusViewModel()
    )
}

