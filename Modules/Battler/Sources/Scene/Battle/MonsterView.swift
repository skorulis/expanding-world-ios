//  Created by Alexander Skorulis on 11/5/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MonsterView {
    let monsters: [Monster]
}

// MARK: - Rendering

extension MonsterView: View {
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<Int((Double(monsters.count) + 2) / 3), id: \.self) { row in
                let startIndex = row * 3
                let endIndex = min(startIndex + 3, monsters.count)
                HStack {
                    ForEach(monsters[startIndex..<endIndex]) { monster in
                        singleMonsterView(monster)
                    }
                }
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
                .init(spec: .rat),
            ]
        )
    }
    
}

