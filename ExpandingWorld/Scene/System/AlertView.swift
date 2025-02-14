//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct AlertView {
    let alert: AlertService.Alert
    let onAction: () -> Void
}

// MARK: - Rendering

extension AlertView: View {
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack {
                Text(alert.message)
                Button(action: onAction) {
                    Text("Ok")
                }
            }
            .padding(12)
            .background(Color.white)
        }
    }
}

// MARK: - Previews

#Preview {
    AlertView(
        alert: .init(message: "Here is my alert"),
        onAction: {}
    )
}

