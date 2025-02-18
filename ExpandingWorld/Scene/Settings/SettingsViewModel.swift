//Created by Alexander Skorulis on 16/2/2025.

import Foundation
import Knit
import KnitMacros

@Observable final class SettingsViewModel {
    
    private let knowledgeStore: KnowledgeStore
    
    @Resolvable<Resolver>
    init(knowledgeStore: KnowledgeStore) {
        self.knowledgeStore = knowledgeStore
    }
    
    private func reset() {
        knowledgeStore.reset()
    }
}
