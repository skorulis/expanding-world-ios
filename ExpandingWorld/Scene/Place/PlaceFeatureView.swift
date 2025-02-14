//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct PlaceFeatureView {
    let feature: Place.Feature
    @State private var expanded: Bool = false
}

// MARK: - Rendering

extension PlaceFeatureView: View {
    
    var body: some View {
        DisclosureGroup(feature.name) {
            Text("Inner")
        }
    }
}

// MARK: - Previews

#Preview {
    let feature = PlaceLibrary.tavern1.features[0]
    PlaceFeatureView(feature: feature)
}

