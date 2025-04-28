//Created by Alexander Skorulis on 15/2/2025.

import Combine
import GameSystem
import Foundation
import Knit
import KnitMacros

@Observable final class ContentViewModel {
    
    let alertService: AlertService
    
    @Resolvable<Resolver>
    init(alertService: AlertService) {
        self.alertService = alertService
    }
}

extension ContentViewModel {
    
}
