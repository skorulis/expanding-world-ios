//  Created by Alexander Skorulis on 19/5/2025.

import DesignSystem
import Foundation
import SwiftUI
import Core

// MARK: - Memory footprint

@MainActor
struct PlayerEquipmentView {
    @State var viewModel: PlayerEquipmentViewModel
}

// MARK: - Rendering

extension PlayerEquipmentView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(title: "Equipment", backAction: { viewModel.coordinator?.pop() })
        } content: {
            VStack {
                equipmentSection
                inventorySection
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var equipmentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Equipment")
                .font(.headline)
            PersonEquipmentLayout(
                inventory: viewModel.player.inventory) { slot in
                    viewModel.unequip(slot: slot)
                }
        }
    }
    
    private var inventorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Inventory \(viewModel.player.money)")
                .font(.headline)
            
            LazyVGrid(columns: [.init(.adaptive(minimum: 100))], spacing: 12) {
                ForEach(viewModel.player.inventory.all, id: \.type) { item in
                    Button(action: { viewModel.tryEquip(item: item)}) {
                        InventoryItemView(item: item)
                    }
                }
            }
        }
    }
}

struct InventoryItemView: View {
    let item: Item.Instance
    
    var body: some View {
        VStack(spacing: 4) {
            item.type.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text(item.type.name)
                .font(.caption)
                .lineLimit(1)
            
            if item.amount > 1 {
                Text("x\(item.amount)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(8)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

// MARK: - Previews

@MainActor
func previewViewModel() -> PlayerEquipmentViewModel {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    let playerStore = resolver.battlerRunStore()
    playerStore.player.inventory
        .add(.init(type: .leatherArmor, amount: 5))
    return resolver.playerEquipmentViewModel()
}

#Preview {
    PlayerEquipmentView(viewModel: previewViewModel())
}

