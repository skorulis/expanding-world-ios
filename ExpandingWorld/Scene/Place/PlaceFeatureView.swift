//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct PlaceFeatureView {
    let feature: Place.Feature
    let onAction: (PlaceAction) -> Void
    @State private var expanded: Bool = false
}

// MARK: - Rendering

extension PlaceFeatureView: View {
    
    var body: some View {
        HStack(alignment: .center) {
            Text(feature.name)
                .font(.title)
            Spacer()
            maybeActions
        }
    }
    
    @ViewBuilder
    private var maybeActions: some View {
        if feature.actions.count > 0 {
            ActionButtonRow(actions: feature.actions) { action in
                onAction(action)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let feature = PlaceLibrary.tavern1.features[0]
    PlaceFeatureView(feature: feature, onAction: { _ in })
        .padding()
}

