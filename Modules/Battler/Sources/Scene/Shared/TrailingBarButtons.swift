//  Created by Alexander Skorulis on 25/5/2025.

import ASKCoordinator
import SwiftUI

// MARK: - Memory footprint

struct TrailingBarButtons {
    let coordinator: Coordinator?
}

// MARK: - Rendering

extension TrailingBarButtons: View {
    
    var body: some View {
        HStack(spacing: 8) {
            characterButton
        }
    }
    
    private var characterButton: some View {
        Button(action: showCharacter) {
            Asset.character.swiftUIImage
                .resizable()
                .frame(width: 32, height: 32)
        }
    }
    
    private func showCharacter() {
        coordinator?.present(
            BattlerPath.mainCharacter,
            style: .sheet
        )
    }
}

// MARK: - Previews

#Preview {
    TrailingBarButtons(coordinator: nil)
}

