//  Created by Alexander Skorulis on 14/7/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct MainCharacterView {
    @State var viewModel: MainCharacterViewModel
}

// MARK: - Rendering

extension MainCharacterView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(title: "Character")
        } content: {
            content
        }
    }
    
    private var content: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Button(action: viewModel.equipment) {
                Text("Equipment")
            }
            .buttonStyle(RectangleButtonStyle())
            
            Button(action: viewModel.skills) {
                Text("Skills")
            }
            .buttonStyle(RectangleButtonStyle())
            
            Button(action: viewModel.effects) {
                Text("Effects")
            }
            .buttonStyle(RectangleButtonStyle())
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    MainCharacterView(
        viewModel: assembler.resolver.mainCharacterViewModel()
    )
}

