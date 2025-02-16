//Created by Alexander Skorulis on 15/2/2025.

import ASKCore
import Foundation

/// Service for managing alerts from other services
final class AlertService: ObservableObject {
    
    @Published private(set) var currentAlert: Alert? {
        didSet {
            if let currentAlert {
                show(alert: currentAlert)
            }
        }
    }
    private var waitingMessages: [Alert] = []
    
    var window: OverlayWindow? {
        didSet {
            if let currentAlert {
                show(alert: currentAlert)
            }
        }
    }
    
    init() {
    }
    
    private func show(alert: Alert) {
        guard let window else {
            return
        }
        guard window.isReady else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.show(alert: alert)
            }
            return
        }
        window.show(AlertView(alert: alert) { [unowned self] in
            self.close()
        })
    }
 
    func post(message: String) {
        let alert = Alert(message: message)
        if currentAlert == nil {
            currentAlert = alert
        } else {
            waitingMessages.append(alert)
        }
    }
    
    func close() {
        self.window?.dismiss()
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
