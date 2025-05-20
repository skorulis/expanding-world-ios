//  Created by Alexander Skorulis on 19/5/2025.

import Foundation

import SwiftUI

// MARK: - Memory footprint

struct PlayerEquipmentView {
    @State var viewModel: PlayerEquipmentViewModel
}

// MARK: - Rendering

extension PlayerEquipmentView: View {
    
    var body: some View {
        EmptyView()
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    PlayerEquipmentView(viewModel: resolver.playerEquipmentViewModel())
}

