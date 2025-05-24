//  Created by Alexander Skorulis on 26/4/2025.

import Foundation
import SwiftUI

struct BattlerPathShape: Shape {
    let sequence: BattlerSequence
    let selection: BattleSequenceIndex?
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var first = true
        guard sequence.path.count > 0 else { return path }
        let maxOptions = sequence.steps.map { $0.options.count }.max() ?? 1
        let maxHeight = height(options: maxOptions)
        var x: CGFloat = SequenceUIConstants.avatarSize / 2
        for i in 0..<min(sequence.path.count, sequence.steps.count) {
            addLine(
                path: &path,
                i: i,
                pos: sequence.path[i],
                maxHeight: maxHeight,
                x: x,
                first: first
            )
            x += SequenceUIConstants.avatarSize + SequenceUIConstants.stepColumnSpacing
            first = false
        }
        if let selection, selection.stepIndex >= sequence.path.count {
            addLine(
                path: &path,
                i: selection.stepIndex,
                pos: selection.optionIndex,
                maxHeight: maxHeight,
                x: x,
                first: first
            )
        }
        
        return path
    }
    
    private func addLine(
        path: inout Path,
        i: Int,
        pos: Int,
        maxHeight: CGFloat,
        x: CGFloat,
        first: Bool
    ) {
        let stepHeight = height(options: sequence.steps[i].options.count)
        let topPadding = (maxHeight - stepHeight) / 2
        let y = topPadding
        + CGFloat(pos) * SequenceUIConstants.avatarSize
        + CGFloat(pos) * SequenceUIConstants.stepRowSpacing
        + SequenceUIConstants.avatarSize / 2
        if first {
            path.move(to: .init(x: x, y: y))
        } else {
            path.addLine(to: .init(x: x, y: y))
        }
    }
    
    private func height(options: Int) -> CGFloat {
        CGFloat(options) * SequenceUIConstants.avatarSize + CGFloat(options - 1) * SequenceUIConstants.stepRowSpacing
    }
}
