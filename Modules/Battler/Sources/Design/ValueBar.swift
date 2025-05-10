//  Created by Alexander Skorulis on 10/5/2025.

import Foundation
import SwiftUI


struct ValueBar {
    let value: CombatantValue
    let color: Color
    
    init(value: CombatantValue, color: Color) {
        self.value = value
        self.color = color
    }
}

extension ValueBar: View {
    
    var body: some View {
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

#Preview {
    VStack(spacing: 8) {
        ValueBar(value: CombatantValue(current: 0, limit: 100), color: .red)
        ValueBar(value: CombatantValue(current: 75, limit: 100), color: .red)
        ValueBar(value: CombatantValue(current: 30, limit: 100), color: .blue)
        ValueBar(value: CombatantValue(current: 100, limit: 100), color: .green)
    }
    .padding()
}
