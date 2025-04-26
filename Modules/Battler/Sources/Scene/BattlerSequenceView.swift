//Created by Alexander Skorulis on 26/4/2025.

import Core
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattlerSequenceView {
    @State var viewModel: BattlerSequenceViewModel
}

// MARK: - Rendering

extension BattlerSequenceView: View {
    
    var body: some View {
        Text("Step X  3212")
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    BattlerSequenceView(viewModel: assembler.resolver.battlerSequenceViewModel())
}

