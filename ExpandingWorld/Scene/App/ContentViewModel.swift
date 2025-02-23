//Created by Alexander Skorulis on 15/2/2025.

import Combine
import Foundation
import Knit
import KnitMacros

@Observable final class ContentViewModel {
    
    var currentAlert: AlertService.Alert?
    private var cancellables: Set<AnyCancellable> = []
    
    let alertService: AlertService
    
    @Resolvable<Resolver>
    init(alertService: AlertService) {
        self.alertService = alertService
        alertService.$currentAlert.sink { [unowned self] alert in
            self.currentAlert = alert
        }
        .store(in: &cancellables)
    }
}

extension ContentViewModel {
    
}
