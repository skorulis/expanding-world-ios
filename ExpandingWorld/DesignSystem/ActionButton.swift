//Created by Alexander Skorulis on 15/2/2025.

import SwiftUI

// MARK: - Memory footprint

struct ActionButton {
    let placeAction: PlaceAction
    let action: () -> Void
    
    private static let size: CGFloat = 80
}

// MARK: - Rendering

extension ActionButton: View {
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                placeAction.icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                Text(placeAction.text)
            }
            .frame(width: ActionButton.size, height: ActionButton.size)
            .background(
                HexagonShape()
                    .stroke(Color.black, lineWidth: 2)
            )
        }
    }
}

struct ActionButtonRow: View {
    let actions: [PlaceAction]
    let onPress: (PlaceAction) -> Void
}

extension ActionButtonRow {
    var body: some View {
        HStack {
            ForEach(actions) { action in
                ActionButton(placeAction: action) {
                    onPress(action)
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ActionButtonRow(actions: [.look, .shop], onPress: {_ in })
    
    
}

