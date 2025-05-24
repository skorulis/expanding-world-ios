//  Created by Alexander Skorulis on 26/4/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattleSequenceStack {
    let sequence: BattlerSequence
    @Binding var selection: BattleSequenceIndex?
}

// MARK: - Rendering

extension BattleSequenceStack: View {
    
    var body: some View {
        HStack(spacing: SequenceUIConstants.stepColumnSpacing) {
            ForEach(Array(sequence.steps.indices), id: \.self) { index in
                BattleStepView(
                    step: sequence.steps[index],
                    selection: stepSelection(index: index)
                )
                .disabled(sequence.path.count > index)
            }
        }
        .background(
            BattlerPathShape(sequence: sequence, selection: selection)
                .stroke(Color.red, lineWidth: 4)
        )
    }
    
    private func stepSelection(index: Int) -> Binding<Int?> {
        return .init {
            if sequence.path.count > index {
                return sequence.path[index]
            }
            guard selection?.stepIndex == index else {
                return nil
            }
            return selection?.optionIndex
        } set: { optionIndex in
            if let optionIndex {
                self.selection = .init(stepIndex: index, optionIndex: optionIndex)
            }
        }

    }
}

// MARK: - Previews

#Preview {
    @Previewable @State var selection: BattleSequenceIndex?
    VStack {
        BattleSequenceStack(
            sequence: .init(
                steps: [
                    .init(stepType: .fight, options: [.testFight()]),
                    .init(stepType: .intermission, options: [.shop(.testShop()), .shop(.testShop())]),
                    .init(stepType: .fight, options: [.testFight(), .testFight(), .testFight()]),
                ],
                path: [0, 1]
            ),
            selection: $selection
        )
    }
    
}

