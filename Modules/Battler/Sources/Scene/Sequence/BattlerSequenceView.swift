//Created by Alexander Skorulis on 26/4/2025.

import Core
import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct BattlerSequenceView {
    @State var viewModel: BattlerSequenceViewModel
}

// MARK: - Rendering

extension BattlerSequenceView: View {
    
    var body: some View {
        if viewModel.player.health.current > 0 {
            aliveView
        } else {
            deadView
        }
    }
    
    private var deadView: some View {
        VStack {
            Text("You dead")
            Button(action: viewModel.finish) {
                Text("Menu")
            }
        }
    }
    
    private var aliveView: some View {
        VStack {
            TitleBar(title: "Battler") {
                TrailingBarButtons(coordinator: viewModel.coordinator)
            }
            
            VStack {
                ScrollView(.horizontal) {
                    BattleSequenceStack(
                        sequence: viewModel.sequence,
                        selection: $viewModel.selection
                    )
                    .padding(.horizontal, 16)
                    
                }
                
                maybeDetails
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private var maybeDetails: some View {
        if let selection = viewModel.selection {
            let option = viewModel.sequence.option(index: selection)
            BattleOptionsDetailView(
                option: option,
                onSelect: viewModel.detailsSelected
            )
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    BattlerSequenceView(viewModel: assembler.resolver.battlerSequenceViewModel())
}

