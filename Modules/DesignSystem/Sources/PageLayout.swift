//  Created by Alexander Skorulis on 24/7/2025.

import Foundation
import SwiftUI

public struct PageLayout<TitleBar: View, Content: View>: View {
    
    private let titleBar: () -> TitleBar
    private let content: () -> Content
    
    public init(titleBar: @escaping () -> TitleBar, content: @escaping () -> Content) {
        self.titleBar = titleBar
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            titleBar()
            ScrollView {
                Spacer()
                    .frame(height: 24)
                content()
            }
        }
        .navigationBarHidden(true)
    }
}
