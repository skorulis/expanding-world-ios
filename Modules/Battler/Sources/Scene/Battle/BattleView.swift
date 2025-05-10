//  Created by Alexander Skorulis on 27/4/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

// View for performing a battle
@MainActor struct BattleView {
    @State var viewModel: BattleViewModel
}

// MARK: - Rendering

extension BattleView: View {
    
    var body: some View {
        VStack {
            // Enemy display area
            Asset.Monsters.monsterRat.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 200)
                .padding()
            
            Spacer()
            
            grid
        }
    }
    
    private var grid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
            ForEach(viewModel.availableActions) { action in
                icon(action: action)
            }
        }
        .padding()
    }
    
    private func icon(action: BattleViewModel.Action) -> some View {
        Button(action: {
            viewModel.perform(action: action)
        }) {
            VStack {
                action.image
                    .font(.system(size: 24))
                Text(action.name)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(8)
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let fight = BattlerFight(monsters: [.rat])
    BattleView(viewModel: resolver.battleViewModel(fight: fight))
}

