//  Created by Alexander Skorulis on 24/5/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattlerMenuView {
    @State var viewModel: BattlerMenuViewModel
}

// MARK: - Rendering

extension BattlerMenuView: View {
    
    var body: some View {
        VStack {
            TitleBar(
                title: "Menu",
                trailing: {
                    TrailingBarButtons(
                        money: nil,
                        coordinator: viewModel.coordinator
                    )
                }
            )
            VStack(spacing: 8) {
                Spacer()
                Button(action: viewModel.start) {
                    Text("Start")
                }
                .buttonStyle(RectangleButtonStyle())
                
                if viewModel.bestiaryUnlocked {
                    Button(action: viewModel.showBestiary) {
                        Text("Bestiary")
                    }
                    .buttonStyle(RectangleButtonStyle())
                }
                
                Button(action: viewModel.showStats) {
                    Text("Stats")
                }
                .buttonStyle(RectangleButtonStyle())
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    BattlerMenuView(viewModel: assembler.resolver.battlerMenuViewModel())
}

