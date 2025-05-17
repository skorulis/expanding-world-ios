//  Created by Alexander Skorulis on 17/5/2025.

import SwiftUI

public struct RectangleButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        var backgroundColor: Color = Color.blue
        if !isEnabled {
            backgroundColor = backgroundColor.opacity(0.4)
        } else if configuration.isPressed {
            backgroundColor = backgroundColor.opacity(0.7)
        }
        return configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(backgroundColor)
            .cornerRadius(12)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        Button("Normal Button") {}
            .buttonStyle(RectangleButtonStyle())
        
        Button("Disabled Button") {}
            .buttonStyle(RectangleButtonStyle())
            .disabled(true)
        
        Button("Pressed Button") {}
            .buttonStyle(RectangleButtonStyle())
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in }
            )
    }
    .padding()
}
