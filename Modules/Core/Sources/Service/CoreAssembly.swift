//  Created by Alexander Skorulis on 27/4/2025.

import GameSystem
import Foundation
import Knit

// @knit public
public final class CoreAssembly: AutoInitModuleAssembly {
    public typealias TargetResolver = BaseResolver
    
    public static var dependencies: [any ModuleAssembly.Type] { [GameSystemAssembly.self]}
    
    public init() {}
    
    public func assemble(container: Container<TargetResolver>) {
        container.register(KnowledgeStore.self) { KnowledgeStore.make(resolver: $0) }
            .inObjectScope(.container)
        
        container.register(PlayerStore.self) { PlayerStore.make(resolver: $0) }
            .inObjectScope(.container)
    }
    
}
