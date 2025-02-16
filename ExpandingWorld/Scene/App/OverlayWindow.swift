//Created by Alexander Skorulis on 16/2/2025.

import SwiftUI

class OverlayWindow {
    private var window: UIWindow?
    
    var isReady: Bool {
        UIApplication.shared.connectedScenes.count > 0
    }
    
    func show<Content: View>(_ view: Content) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = UIWindow(windowScene: windowScene!)
        window.rootViewController = UIHostingController(rootView: view)
        window.rootViewController?.view.backgroundColor = .clear
        window.windowLevel = .alert + 1 // Above all other layers
        window.makeKeyAndVisible()
        window.backgroundColor = .clear
        self.window = window
    }
    
    func dismiss() {
        window?.isHidden = true
        window = nil
    }
}
