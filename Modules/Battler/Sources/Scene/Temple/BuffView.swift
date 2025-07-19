//  Created by Alexander Skorulis on 14/7/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BuffView {
    let buff: StatusEffect
}

// MARK: - Rendering

extension BuffView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(buff.name)
                effects
                if showDuration {
                    Text("\(buff.duration.description) remaining")
                }
            }
            Spacer()
        }
        .padding(12)
    }
    
    private var effects: some View {
        HStack(spacing: 0) {
            buff.effect.icon
                .resizable()
                .frame(width: 24, height: 24)
            
            Text(buff.effect.postText)
        }
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

private extension BuffEffect {
    var postText: String {
        switch self {
        case let .attack(int):
            return "+\(int)"
        case let .defence(int):
            return "+\(int)"
        case let .healing(int):
            return "+\(int)"
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

