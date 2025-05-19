//  Created by Alexander Skorulis on 10/5/2025.

import Foundation
import SwiftUI

public struct ValueBar {
    let value: CurrentValueType
    let color: Color
    
    public init(value: CurrentValueType, color: Color) {
        self.value = value
        self.color = color
    }
}

extension ValueBar: View {
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background bar
                Rectangle()
                    .fill(color.opacity(0.3))
                
                // Foreground progress bar
                Rectangle()
                    .fill(color)
                    .frame(width: geometry.size.width * value.fraction)
                
                // Text overlay
                HStack {
                    Text(value.string)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                    Spacer()
                }
            }
        }
        .frame(height: 24)
        .cornerRadius(8)
    }
}

private struct ExampleValue: CurrentValueType {
    let current: Int
    let limit: Int
}

#Preview {
    VStack(spacing: 8) {
        ValueBar(value: ExampleValue(current: 0, limit: 100), color: .red)
        ValueBar(value: ExampleValue(current: 75, limit: 100), color: .red)
        ValueBar(value: ExampleValue(current: 30, limit: 100), color: .blue)
        ValueBar(value: ExampleValue(current: 100, limit: 100), color: .green)
    }
    .padding()
}
