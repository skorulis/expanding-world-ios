//  Created by Alexander Skorulis on 20/5/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct BestiaryEntryView {
    @State var viewModel: BestiaryEntryViewModel
}

// MARK: - Rendering

extension BestiaryEntryView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            TitleBar(
                title: viewModel.monster.name,
                backAction: { viewModel.coordinator?.pop() }
            )
            
            ScrollView {
                VStack(spacing: 24) {
                    monsterImage
                    statsSection
                    abilitiesSection
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    private var monsterImage: some View {
        viewModel.monster.image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 200)
            .background(Color(.systemGray6))
            .cornerRadius(12)
    }
    
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Stats")
                .font(.headline)
            
            HStack(spacing: 24) {
                statView(
                    icon: Asset.Icon.heart.swiftUIImage,
                    color: .red,
                    value: "\(viewModel.monster.health)",
                    label: "Health"
                )
                
                statView(
                    icon: Asset.Icon.skull.swiftUIImage,
                    color: .gray,
                    value: "\(viewModel.kills)",
                    label: "Kills"
                )
                
                statView(
                    icon: Asset.Icon.attack.swiftUIImage,
                    color: .gray,
                    value: "\(viewModel.monster.attack)",
                    label: "Attack"
                )
                
                statView(
                    icon: Asset.Icon.defence.swiftUIImage,
                    color: .gray,
                    value: "\(viewModel.monster.defence)",
                    label: "Defence"
                )
            }
        }
    }
    
    private func statView(icon: Image, color: Color, value: String, label: String) -> some View {
        VStack(spacing: 4) {
            icon
                .resizable()
                .frame(width: 28, height: 28)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.headline)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    private var abilitiesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Abilities")
                .font(.headline)
            
            ForEach(Array(viewModel.monster.abilities.indices), id: \.self) { index in
                abilityRow(ability: viewModel.monster.abilities[index])
            }
        }
    }
    
    private func abilityRow(ability: AttackAbility) -> some View {
        HStack {
            Image(systemName: "bolt.fill")
                .foregroundColor(.yellow)
            
            Text(ability.name)
                .font(.subheadline)
            
            Spacer()
            
            if let damage = ability.damangeRangeString {
                Text("Damage: \(damage)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    BestiaryEntryView(
        viewModel: assembler.resolver.bestiaryEntryViewModel(monster: .rat)
    )
} 
