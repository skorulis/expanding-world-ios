//  Created by Alexander Skorulis on 11/5/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MonsterView {
    let monsters: [Monster]
}

// MARK: - Rendering

extension MonsterView: View {
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
            ForEach(monsters) { monster in
                singleMonsterView(monster)
            }
        }
    }
    
    @ViewBuilder
    private func singleMonsterView(_ monster: Monster) -> some View {
        ZStack {
            monster.spec.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 120)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing) {
            ValueCircle(value: monster.health, color: .red)
        }
    }
}

// MARK: - Previews

#Preview {
    VStack(spacing: 8) {
        MonsterView(
            monsters: [
                .init(spec: .rat),
                .init(spec: .rat),
            ]
        )
        Color.black
            .frame(height: 2)
        MonsterView(
            monsters: [
                .init(spec: .rat),
                .init(spec: .rat),
                .init(spec: .rat),
                .init(spec: .rat),
            ]
        )
    }
    
}

