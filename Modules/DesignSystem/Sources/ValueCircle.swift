//  Created by Alexander Skorulis on 10/5/2025.

import Foundation
import SwiftUI

public protocol CurrentValueType {
    var current: Int { get }
    var limit: Int { get }
}

public extension CurrentValueType {
    var string: String {
        return "\(current)/\(limit)"
    }
    
    var fraction: CGFloat {
        CGFloat(current) / CGFloat(limit)
    }
}

public struct ValueCircle {
    let value: CurrentValueType
    let color: Color
    let size: CGFloat
    
    public init(value: CurrentValueType, color: Color, size: CGFloat = 60) {
        self.value = value
        self.color = color
        self.size = size
    }
}

extension ValueCircle: View {
    
    public var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(color.opacity(0.3), lineWidth: 8)
            
            // Progress circle
            Circle()
                .trim(from: 0, to: value.fraction)
                .stroke(color, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            // Value text
            Text("\(value.current)")
                .font(.body)
                .foregroundColor(.primary)
        }
        .frame(width: size, height: size)
    }
}

private struct ExampleValue: CurrentValueType {
    let current: Int
    let limit: Int
}

#Preview {
    VStack(spacing: 16) {
        ValueCircle(value: ExampleValue(current: 0, limit: 100), color: .red)
        ValueCircle(value: ExampleValue(current: 75, limit: 100), color: .red)
        ValueCircle(value: ExampleValue(current: 30, limit: 100), color: .blue)
        ValueCircle(value: ExampleValue(current: 100, limit: 100), color: .green)
    }
    .padding()
}
