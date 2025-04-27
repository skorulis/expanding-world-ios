//  Created by Alexander Skorulis on 27/4/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

// View for performing a battle
struct BattleView {
    @State var viewModel: BattleViewModel
}

// MARK: - Rendering

extension BattleView: View {
    
    var body: some View {
        EmptyView()
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let fight = BattlerFight(monsters: [.rat])
    BattleView(viewModel: resolver.battleViewModel(fight: fight))
}

