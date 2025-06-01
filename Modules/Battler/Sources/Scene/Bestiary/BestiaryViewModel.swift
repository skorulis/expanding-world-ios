//  Created by Alexander Skorulis on 20/5/2025.

import Knit
import KnitMacros
import ASKCoordinator
import Core
import Foundation
import SwiftUI

@Observable final class BestiaryViewModel: CoordinatorViewModel {
    
    var coordinator: Coordinator?
    
    @Resolvable<Resolver>
    public init() {

    }
}

// MARK: - Logic

extension BestiaryViewModel {
    var entries: [MonsterSpec] {
        MonsterSpec.allCases
    }
    
    func select(_ entry: MonsterSpec) {
        
    }
}
