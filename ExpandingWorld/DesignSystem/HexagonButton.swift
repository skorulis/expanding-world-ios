//Created by Alexander Skorulis on 18/2/2025.

import Core
import Foundation
import Hex
import SwiftUI

struct HexagonButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .multilineTextAlignment(.center)
            .frame(width: ActionButton.size, height: ActionButton.size)
            .background(
                HexagonShape()
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}
