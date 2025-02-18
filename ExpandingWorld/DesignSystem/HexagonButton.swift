//Created by Alexander Skorulis on 18/2/2025.

import Foundation
import SwiftUI

struct HexagonButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: ActionButton.size, height: ActionButton.size)
            .background(
                HexagonShape()
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}
