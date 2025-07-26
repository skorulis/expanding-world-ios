//  Created by Alexander Skorulis on 26/7/2025.

import DesignSystem
import SwiftUI

// MARK: - Memory footprint

struct BattlerStatsView {
    @State var viewModel: BattlerStatsViewModel
}

// MARK: - Rendering

extension BattlerStatsView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(title: "Stats", backAction: { viewModel.coordinator?.pop() })
        } content: {
            stats
        }
    }
    
    private var stats: some View {
        VStack(spacing: 8) {
            Text("Battler runs: \(viewModel.stats.gameStarts)")
            Text("Kills: \(viewModel.stats.totalKills)")
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    BattlerStatsView(viewModel: assembler.resolver.battlerStatsViewModel())
}

