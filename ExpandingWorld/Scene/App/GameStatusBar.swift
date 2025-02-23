//Created by Alexander Skorulis on 23/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct GameStatusBar {
    @State var viewModel: GameStatusBarViewModel
}

// MARK: - Rendering

extension GameStatusBar: View {
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if viewModel.showTime {
                    Text(TimeFormatter.default.format(time: viewModel.seconds))
                }
                Spacer()
            }
            .frame(height: viewModel.height)
            .padding(.horizontal, 24)
            Divider()
        }
        .ignoresSafeArea(edges: .all)
    }
    
    
}

// MARK: - Previews

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    GameStatusBar(viewModel: assembler.resolver.gameStatusBarViewModel())
}

