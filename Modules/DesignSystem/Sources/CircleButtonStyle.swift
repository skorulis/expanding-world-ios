//  Created by Alexander Skorulis on 2/9/2025.

import SwiftUI

public struct CircleButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(16)
            .background(
                Circle()
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(configuration.isPressed ? 0.08 : 0.18), radius: configuration.isPressed ? 2 : 6, x: 0, y: configuration.isPressed ? 1 : 3)
            )
            .overlay(
                Circle()
                    .strokeBorder(
                        configuration.isPressed ? Color.accentColor.opacity(0.7) : Color.accentColor,
                        lineWidth: configuration.isPressed ? 3 : 2
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

#Preview {
    HStack {
        Button(action: {}) {
            Image(systemName: "square.and.arrow.down")
                .resizable()
                .frame(width: 44, height: 44)
        }
        .buttonStyle(CircleButtonStyle())
        
        Button(action: {}) {
            Image(systemName: "square.and.arrow.down")
                .resizable()
                .frame(width: 44, height: 44)
        }
        .buttonStyle(CircleButtonStyle())
    }
    
}
