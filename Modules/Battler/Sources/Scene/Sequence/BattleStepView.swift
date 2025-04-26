//  Created by Alexander Skorulis on 26/4/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattleStepView {
    let step: BattleStep
}

// MARK: - Rendering

extension BattleStepView: View {
    
    var body: some View {
        VStack(spacing: SequenceUIConstants.stepRowSpacing) {
            ForEach(Array(step.options.indices), id: \.self) { index in
                optionView(step.options[index])
            }
        }
    }
    
    private func optionView(_ option: BattleOption) -> some View {
        image(option)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
                width: SequenceUIConstants.avatarImageSize,
                height: SequenceUIConstants.avatarImageSize
            )
            .foregroundStyle(Color.white)
            .padding(SequenceUIConstants.avatarPadding)
            .background(
                Circle()
                    .fill(Color.black)
            )
    }
    
    private func image(_ option: BattleOption) -> Image {
        switch option {
        case .fight:
            return Image(systemName: "person.2.fill")
        case .shop:
            return Image(systemName: "dollarsign.bank.building.fill")
        }
    }
}

// MARK: - Previews

#Preview {
    HStack {
        BattleStepView(
            step: .init(stepType: .fight, options: [.fight, .fight])
        )
    }
    
}

