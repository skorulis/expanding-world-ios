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
            invButton
        }
    }
    
    private var invButton: some View {
        Button(action: showInventory) {
            Asset.chest.swiftUIImage
                .resizable()
                .frame(width: 32, height: 32)
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
        coordinator?.present(BattlerPath.character, style: .sheet)
    }
    
    private func showInventory() {
        coordinator?.present(BattlerPath.equipment, style: .sheet)
    }
}

// MARK: - Previews

#Preview {
    TrailingBarButtons(coordinator: nil)
}

