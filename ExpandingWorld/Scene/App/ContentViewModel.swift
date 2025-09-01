//Created by Alexander Skorulis on 15/2/2025.

import Battler
import Combine
import GameSystem
import Foundation
import Knit
import KnitMacros

@Observable final class ContentViewModel {
    
    let alertService: AlertService
    let battlerStatsMonitor: BattlerStatsMonitor
    
    @Resolvable<BaseResolver>
    init(alertService: AlertService, battlerStatsMonitor: BattlerStatsMonitor) {
        self.alertService = alertService
        
        // Hold onto the stats monitor so it will monitor changes
        self.battlerStatsMonitor = battlerStatsMonitor
    }
}

extension ContentViewModel {
    
}
