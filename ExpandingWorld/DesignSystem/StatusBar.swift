//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct StatusBar {
    let value: Float
    let max: Float
    
    @State private var size: CGSize = .zero
}

// MARK: - Rendering

extension StatusBar: View {
    
    var fraction: CGFloat {
        return CGFloat(value) / CGFloat(max)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.green)
                .frame(width: fraction * size.width)
            Rectangle()
                .stroke(Color.black)
        }
        .frame(height: 32)
        .readSize(size: $size)
    }
}

// MARK: - Previews

#Preview {
    VStack {
        StatusBar(value: 5, max: 10)
        StatusBar(value: 2, max: 10)
        StatusBar(value: 10, max: 10)
        StatusBar(value: 0, max: 10)
    }
    .padding()
}

