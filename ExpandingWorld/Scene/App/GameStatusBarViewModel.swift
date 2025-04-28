//Created by Alexander Skorulis on 23/2/2025.

import Combine
import Core
import Foundation
import Knit
import KnitMacros
import SwiftUI

@Observable final class GameStatusBarViewModel {
    
    private let timeStore: TimeStore
    private let knowledgeStore: KnowledgeStore
    
    let height: CGFloat
    
    var showTime: Bool = false
    var seconds: Int64 = 0
    private var cancellables: Set<AnyCancellable> = []
    
    @Resolvable<Resolver>
    init(timeStore: TimeStore, knowledgeStore: KnowledgeStore) {
        self.timeStore = timeStore
        self.knowledgeStore = knowledgeStore
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        timeStore.$seconds.sink { [unowned self] value in
            self.seconds = value
        }
        .store(in: &cancellables)
        
        knowledgeStore.$knowledge.sink { [unowned self] value in
            self.showTime = value.gameFeatures.contains(.time)
        }
        .store(in: &cancellables)
    }
}
