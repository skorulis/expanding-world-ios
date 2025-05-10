//  Created by Alexander Skorulis on 10/5/2025.

import Foundation
import SwiftUI

enum MonsterSpec {
    case rat
    
    var image: Image {
        switch self {
        case .rat:
            return Asset.Monsters.monsterRat.swiftUIImage
        }
    }
}

