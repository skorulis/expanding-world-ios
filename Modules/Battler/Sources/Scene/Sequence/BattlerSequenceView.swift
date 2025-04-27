//Created by Alexander Skorulis on 26/4/2025.

import Core
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattlerSequenceView {
    @State var viewModel: BattlerSequenceViewModel
}

// MARK: - Rendering

extension BattlerSequenceView: View {
    
    var body: some View {
        VStack {
            Text("Battler")
            ScrollView {
                VStack {
                    BattleSequenceStack(
                        sequence: viewModel.sequence,
                        selection: $viewModel.selection
                    )
                    maybeDetails
                }
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

