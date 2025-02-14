//Created by Alexander Skorulis on 15/2/2025.

import Foundation

final class GameService {
    
    private let alertService: AlertService
    
    init(alertService: AlertService) {
        self.alertService = alertService
    }
    
    func startNewGame() {
        alertService.post(message: "You wake up in a dimly lit small room with a few tables and a bar towards the back of the room")
    }
    
    func loadSavedGame() {
        // TODO: Unimplemented
    }
}
