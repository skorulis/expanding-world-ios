//  Created by Alexander Skorulis on 26/4/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattleOptionsDetailView {
    let option: BattleOption
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
            }
            Button(action: {}) {
                Text("Select")
            }
        }
        .padding(16)
        .border(Color.black)
    }
    
    private func fightDetails(_ fight: BattlerFight) -> some View {
        VStack {
            Text("Fight \(fight.monsters.count) monsters")
        }
    }
    
    private var shopDetails: some View {
        Text("Shop")
    }
}

// MARK: - Previews

#Preview {
    BattleOptionsDetailView(
        option: .testFight()
    )
}

