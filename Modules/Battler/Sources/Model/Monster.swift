//  Created by Alexander Skorulis on 26/4/2025.

import Foundation
import SwiftUI

enum Monster {
    case rat
    
    var image: Image {
        switch self {
        case .rat:
            return Asset.Monsters.monsterRat.swiftUIImage
        }
    }
}
