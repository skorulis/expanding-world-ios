//  Created by Alexander Skorulis on 26/4/2025.

import Core
import Foundation
import Knit

public final class BattlerAssembly: AutoInitModuleAssembly {
    public typealias TargetResolver = Resolver
    
    public init() {}
    
    public func assemble(container: Container<TargetResolver>) {
        container.register(BattleStepGenerator.self) { _ in
            BattleStepGenerator()
        }
        
        container.register(BattlerSequenceViewModel.self) { resolver in
            BattlerSequenceViewModel(generator: resolver.battleStepGenerator())
        }
        
        container.register(BattleViewModel.self) { (resovler: Resolver, fight: BattlerFight) in
            BattleViewModel(fight: fight)
        }
        
        // @knit public
        container.register(BattlerPathRenderer.self) { resolver in
            BattlerPathRenderer(resolver: resolver)
        }
    }
    
    public static var dependencies: [any Knit.ModuleAssembly.Type] { [] }
    
}

public extension BattlerAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<Resolver> {
        return ScopedModuleAssembler<Resolver>([BattlerAssembly()])
    }
}
