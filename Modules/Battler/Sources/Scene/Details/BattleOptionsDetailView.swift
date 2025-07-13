//  Created by Alexander Skorulis on 26/4/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattleOptionsDetailView {
    let option: BattleOption
    let onSelect: () -> Void
}

// MARK: - Rendering

extension BattleOptionsDetailView: View {
    
    var body: some View {
        VStack {
            switch option {
            case let .fight(fight):
                fightDetails(fight)
            case .shop:
                shopDetails
            case .temple:
                templeDetails()
            }
            Button(action: onSelect) {
                Text("Select")
            }
        }
        .padding(16)
        .border(Color.black)
    }
    
    private func fightDetails(_ fight: BattlerFight) -> some View {
        VStack {
            Text("Fight \(fight.monsterDescriptions)")
            Text("Reward: \(fight.reward) gold")
        }
    }
    
    private var shopDetails: some View {
        Text("Shop")
    }
    
    private func templeDetails() -> some View {
        Text("Temple")
    }
}

// MARK: - Previews

#Preview {
    BattleOptionsDetailView(
        option: .testFight(),
        onSelect: {}
    )
}

