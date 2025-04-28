//Created by Alexander Skorulis on 15/2/2025.

import ASKCore
import Foundation
import UIKit

/// Service for managing alerts from other services
public final class AlertService: ObservableObject {
    
    @MainActor @Published private(set) var currentAlert: Alert? {
        didSet {
            if let currentAlert {
                show(alert: currentAlert)
            }
        }
    }
    private var waitingMessages: [Alert] = []
    
    @MainActor public var window: OverlayWindow? {
        didSet {
            if let currentAlert {
                show(alert: currentAlert)
            }
        }
    }
    
    init() {
    }
    
    @MainActor private func show(alert: Alert) {
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
 
    @MainActor public func post(message: String) {
        let alert = Alert(message: message)
        if currentAlert == nil {
            currentAlert = alert
        } else {
            waitingMessages.append(alert)
        }
    }
    
    @MainActor public func close() {
        self.window?.dismiss()
        currentAlert = nil
        if waitingMessages.count > 0 {
            currentAlert = waitingMessages.removeFirst()
        }
    }
}

extension AlertService {
    public struct Alert: Equatable, Identifiable {
        public let id: UUID = UUID()
        let message: String
    }
}
