//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SettingsView {
    
    @State var viewModel: SettingsViewModel
}

// MARK: - Rendering

extension SettingsView: View {
    
    var body: some View {
        VStack {
            Button(action: {}) {
                Text("Reset Data")
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    SettingsView(viewModel: assembler.resolver.settingsViewModel())
}

