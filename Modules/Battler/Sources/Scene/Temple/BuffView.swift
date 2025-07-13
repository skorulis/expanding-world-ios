//  Created by Alexander Skorulis on 14/7/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BuffView {
    let buff: Buff
}

// MARK: - Rendering

extension BuffView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(buff.name)
                Text(buff.effect.description)
                if showDuration {
                    Text("\(buff.duration.description) remaining")
                }
            }
            Spacer()
        }
        .padding(12)
    }
    
    var showDuration: Bool {
        switch buff.duration {
        case .battles, .rounds:
            return true
        default:
            return false
        }
    }
}

// MARK: - Previews

#Preview {
    VStack {
        BuffView(
            buff: .init(
                name: "My Buff",
                effect: .attack(3),
                duration: .battles(2)
            )
        )
    }
}

