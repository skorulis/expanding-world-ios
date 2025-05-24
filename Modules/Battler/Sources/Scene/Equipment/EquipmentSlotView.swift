//  Created by Alexander Skorulis on 23/5/2025.

import Core
import SwiftUI

// MARK: - Memory footprint

struct EquipmentSlotView {
    let slot: EquipmentSlot
    let item: Item.Instance?
    let onPress: (EquipmentSlot) -> Void
}

// MARK: - Rendering

extension EquipmentSlotView: View {
    
    var body: some View {
        Button(action: {onPress(slot)}) {
            content
        }
    }
    
    private var content: some View {
        ZStack {
            maybeDescription
            
            maybeItem
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .frame(height: 80)
        }
        .frame(width: 80)
    }
    
    @ViewBuilder
    private var maybeDescription: some View {
        if item == nil {
            Text(slot.rawValue.capitalized)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    private var maybeItem: some View {
        if let item = item {
            item.type.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
        }
    }
}

// MARK: - Previews

#Preview {
    HStack {
        EquipmentSlotView(
            slot: .body,
            item: nil,
            onPress: {_ in }
        )
        
        EquipmentSlotView(
            slot: .body,
            item: .init(type: .leatherArmor, amount: 1),
            onPress: {_ in }
        )
    }
}

