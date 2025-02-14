//Created by Alexander Skorulis on 15/2/2025.

import Foundation

/// Service for managing alerts from other services
final class AlertService: ObservableObject {
    
    @Published private(set) var currentAlert: Alert?
    private var waitingMessages: [Alert] = []
 
    func post(message: String) {
        let alert = Alert(message: message)
        if currentAlert == nil {
            currentAlert = alert
        } else {
            waitingMessages.append(alert)
        }
    }
    
    func close() {
        currentAlert = nil
        if waitingMessages.count > 0 {
            currentAlert = waitingMessages.removeFirst()
        }
    }
}

extension AlertService {
    struct Alert: Equatable, Identifiable {
        let id: UUID = UUID()
        let message: String
    }
}
