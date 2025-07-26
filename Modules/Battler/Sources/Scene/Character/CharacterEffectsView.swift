//  Created by Alexander Skorulis on 19/7/2025.

import DesignSystem
import SwiftUI

// MARK: - Memory footprint

struct CharacterEffectsView {
    @State var viewModel: CharacterEffectsViewModel
}

// MARK: - Rendering

extension CharacterEffectsView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(title: "Status Effects", backAction: { viewModel.coordinator?.pop() })
        } content: {
            VStack {
                statusEffects
            }
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private var statusEffects: some View {
        if viewModel.effects.isEmpty {
            Text("No status effects")
        } else {
            Text("TODO")
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    CharacterEffectsView(
        viewModel: assembler.resolver.characterEffectsViewModel()
    )
}

