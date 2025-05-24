//  Created by Alexander Skorulis on 23/5/2025.

import Core
import SwiftUI

// MARK: - Memory footprint

struct PersonEquipmentLayout {
    let inventory: Inventory
    let onPress: (EquipmentSlot) -> Void
}

// MARK: - Rendering

extension PersonEquipmentLayout: View {
    
    var body: some View {
        VStack(spacing: 8) {
            EquipmentSlotView(
                slot: .head,
                item: inventory.equipped(.head),
                onPress: onPress
            )
            HStack(spacing: 8) {
                EquipmentSlotView(
                    slot: .body,
                    item: inventory.equipped(.body),
                    onPress: onPress
                )
            }
            EquipmentSlotView(
                slot: .feet,
                item: inventory.equipped(.feet),
                onPress: onPress
            )
        }
    }
}

// MARK: - Previews

#Preview {
    var inv = Inventory(items: [.init(type: .leatherArmor, amount: 1)])
    inv.equip(.leatherArmor, .body)
    return PersonEquipmentLayout(inventory: inv, onPress: { _ in })
}

