//  Created by Alexander Skorulis on 3/8/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct FightLogView {
    let logs: [FightLog]
}

// MARK: - Rendering

extension FightLogView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(logs) { log in
                    HStack(spacing: 0) {
                        Text(log.message)
                        Spacer()
                    }
                }
            }
            .padding(4)
        }
        .border(Color.black)
    }
}

// MARK: - Previews

#Preview {
    FightLogView(
        logs: [
            .init(message: "Rat hits for 5 damage"),
            .init(message: "Player misses"),
            .init(message: "Rat hits for 5 damage"),
            .init(message: "Rat misses"),
            .init(message: "The fight started"),
        ]
    )
}

