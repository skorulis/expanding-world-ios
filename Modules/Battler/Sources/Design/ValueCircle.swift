//  Created by Alexander Skorulis on 10/5/2025.

import Foundation

import SwiftUI

struct ValueCircle {
    let value: CombatantValue
    let color: Color
    let size: CGFloat
    
    init(value: CombatantValue, color: Color, size: CGFloat = 60) {
        self.value = value
        self.color = color
        self.size = size
    }
}

extension ValueCircle: View {
    
    var body: some View {
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

#Preview {
    VStack(spacing: 16) {
        ValueCircle(value: CombatantValue(current: 0, limit: 100), color: .red)
        ValueCircle(value: CombatantValue(current: 75, limit: 100), color: .red)
        ValueCircle(value: CombatantValue(current: 30, limit: 100), color: .blue)
        ValueCircle(value: CombatantValue(current: 100, limit: 100), color: .green)
    }
    .padding()
}
