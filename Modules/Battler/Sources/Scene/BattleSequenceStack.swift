//  Created by Alexander Skorulis on 26/4/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattleSequenceStack {
    let sequence: BattlerSequence
}

// MARK: - Rendering

extension BattleSequenceStack: View {
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(sequence.steps) { step in
                BattleStepView(step: step)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    VStack {
        BattleSequenceStack(
            sequence: .init(
                steps: [
                    .init(stepType: .fight, options: [.fight]),
                    .init(stepType: .intermission, options: [.shop, .shop]),
                    .init(stepType: .fight, options: [.fight, .fight, .fight]),
                ],
                path: [0, 1]
            )
        )
    }
    
}

