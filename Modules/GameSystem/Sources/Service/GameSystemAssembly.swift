//  Created by Alexander Skorulis on 27/4/2025.

import Knit
import Foundation

// @knit public
public final class GameSystemAssembly: AutoInitModuleAssembly {
    public typealias TargetResolver = Resolver
    
    public static var dependencies: [any Knit.ModuleAssembly.Type] { [] }
    
    public init() {}
    
    public func assemble(container: Container<any TargetResolver>) {
        container.register(AlertService.self) { _ in AlertService() }
            .inObjectScope(.container)
    }
    
}
