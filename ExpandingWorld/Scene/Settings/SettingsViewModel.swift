//Created by Alexander Skorulis on 16/2/2025.

import ASKCore
import Core
import Foundation
import Knit
import KnitMacros

@Observable final class SettingsViewModel {
    
    private let knowledgeStore: KnowledgeStore
    private let resettableServiceProvider: ResettableServiceProvider
    
    @Resolvable<Resolver>
    init(
        knowledgeStore: KnowledgeStore,
        resettableServiceProvider: @escaping ResettableServiceProvider
    ) {
        self.knowledgeStore = knowledgeStore
        self.resettableServiceProvider = resettableServiceProvider
    }
    
    func reset() {
        resettableServiceProvider().forEach { $0.resetData() }
    }
}
