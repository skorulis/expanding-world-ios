//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct NavBar {
    let leadingButton: NavBarButton?
    let title: String
    let trailingButton: NavBarButton?
    
    init(
        leadingButton: NavBarButton? = nil,
        title: String,
        trailingButton: NavBarButton? = nil
    ) {
        self.leadingButton = leadingButton
        self.title = title
        self.trailingButton = trailingButton
    }
}

// MARK: - Rendering

extension NavBar: View {
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                maybeLeftButton
                Spacer()
                
                Text(title)
                    .font(.title)
                
                Spacer()
                
                maybeRightButton
            }
            .frame(height: 43)
            Divider()
        }
    }
    
    @ViewBuilder
    private var maybeLeftButton: some View {
        if let leadingButton {
            leadingButton
        } else {
            Spacer()
                .frame(width: 48)
        }
    }
    
    @ViewBuilder
    private var maybeRightButton: some View {
        if let trailingButton {
            trailingButton
        } else {
            Spacer()
                .frame(width: 48)
        }
    }
}

struct NavBarButton {
    let icon: Image
    let action: () -> Void
}

extension NavBarButton: View {
    
    var body: some View {
        Button(action: action) {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
        }
        .padding(.leading, 16)
    }
}

// MARK: - Previews

#Preview {
    VStack {
        NavBar(
            leadingButton: .init(
                icon: Image(systemName: "xmark.circle.fill"),
                action: {}
            ),
            title: "Inventory"
        )
        .border(Color.red)
    }
}

