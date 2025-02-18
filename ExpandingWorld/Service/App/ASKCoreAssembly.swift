//Created by Alexander Skorulis on 17/2/2025.

import ASKCore
import Foundation
import Knit

public struct ASKCoreAssembly: AutoInitModuleAssembly {
    public typealias TargetResolver = Resolver

    private let purpose: IOCPurpose
    
    public init() {
        self.purpose = .testing
    }
    
    public init(purpose: IOCPurpose) {
        self.purpose = purpose
    }
    
    public func assemble(container: Container) {
        container.register(IOCPurpose.self) { _ in
            return purpose
        }
        
        container.register(GenericFactory.self) { res in
            return GenericFactory(container: container)
        }
        .implements(PFactory.self)
        
        container.register(PKeyValueStore.self) { _ in
            switch purpose {
            case .normal:
                return UserDefaults.standard
            case .testing:
                return InMemoryDefaults()
            }
        }
        .inObjectScope(.container)
    }
    
    
    public static var dependencies: [any Knit.ModuleAssembly.Type] = []
    
}
