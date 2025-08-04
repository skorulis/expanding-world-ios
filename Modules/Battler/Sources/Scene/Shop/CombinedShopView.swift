//  Created by Alexander Skorulis on 4/8/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

// A shop that includes all the different options
@MainActor struct CombinedShopView {
    @State var viewModel: CombinedShopViewModel
}

// MARK: - Rendering

extension CombinedShopView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(title: "Shop") {
                TrailingBarButtons(
                    money: viewModel.player.money,
                    coordinator: viewModel.coordinator
                )
            }
        } content: {
            content
        }
    }
    
    private var content: some View {
        VStack(spacing: 8) {
            selectedContent
            Spacer()
            Button(action: viewModel.finish) {
                Text("Finish")
            }
            .buttonStyle(RectangleButtonStyle())
            .padding(.horizontal, 16)
        }
    }
    
    private var selectedContent: some View {
        GeneralShopView(viewModel: viewModel.generalShopViewModel)
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    CombinedShopView(viewModel: assembler.resolver.combinedShopViewModel())
}

