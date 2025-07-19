//  Created by Alexander Skorulis on 14/7/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MainCharacterView {
    @State var viewModel: MainCharacterViewModel
}

// MARK: - Rendering

extension MainCharacterView: View {
    
    var body: some View {
        VStack(spacing: 12) {
            TitleBar(title: "Character")
            Spacer()
            
            Button(action: viewModel.equipment) {
                Text("Equipment")
            }
            .buttonStyle(RectangleButtonStyle())
            
            Button(action: viewModel.skills) {
                Text("Skills")
            }
            .buttonStyle(RectangleButtonStyle())
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarHidden(true)
        
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    MainCharacterView(
        viewModel: assembler.resolver.mainCharacterViewModel()
    )
}

