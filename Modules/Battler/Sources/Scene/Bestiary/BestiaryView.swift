//  Created by Alexander Skorulis on 20/5/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct BestiaryView {
    @State var viewModel: BestiaryViewModel
}

// MARK: - Rendering

extension BestiaryView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            TitleBar(title: "Bestiary")
            listView
        }
    }
    
    private var listView: some View {
        List(viewModel.entries) { entry in
            Button(action: {
                viewModel.select(entry)
            }) {
                cell(entry)
            }
            .listRowSeparator(.hidden)
        }
        .listSectionSeparator(.hidden)
        .listStyle(.plain)
    }
    
    private func cell(_ entry: MonsterSpec) -> some View {
        HStack(spacing: 12) {
            entry.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.name)
                    .font(.headline)
                
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(entry.health)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text("Kills: \(viewModel.kills(monster: entry))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    BestiaryView(viewModel: assembler.resolver.bestiaryViewModel())
}

