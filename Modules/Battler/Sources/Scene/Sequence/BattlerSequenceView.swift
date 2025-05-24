//Created by Alexander Skorulis on 26/4/2025.

import Core
import DesignSystem
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
            TitleBar(title: "Battler") {
                invButton
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
    
    private var invButton: some View {
        Button(action: viewModel.showInventory) {
            Asset.chest.swiftUIImage
                .resizable()
                .frame(width: 32, height: 32)
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

