//  Created by Alexander Skorulis on 27/7/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct GameOverView {
    @State var viewModel: GameOverViewModel
}

// MARK: - Rendering

extension GameOverView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(title: "Game Over")
        } content: {
            VStack {
                Text("Fights won: \(0)")
                Text("Gold earned: \(0)")
                Text("Damage dealt: \(viewModel.roundStats.damageDealt)")
                Text("Damage taken: \(viewModel.roundStats.damageTaken)")
                
                Button(action: viewModel.finish) {
                    Text("Main Menu")
                }
                .buttonStyle(RectangleButtonStyle())
            }
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    GameOverView(viewModel: assembler.resolver.gameOverViewModel())
}


