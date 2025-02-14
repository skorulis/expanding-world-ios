//Created by Alexander Skorulis on 14/2/2025.

import Foundation
import Knit

final class ExpandingWorldAssembly: AutoInitModuleAssembly {
    typealias TargetResolver = Resolver
    static var dependencies: [any Knit.ModuleAssembly.Type] = []
    
    @MainActor func assemble(container: Container) {
        registerServices(container: container)
        registerStores(container: container)
        registerViewModels(container: container)
    }
    
    @MainActor
    private func registerServices(container: Container) {
        container.register(ActionService.self) { r in
            ActionService.make(resolver: r)
        }
    }
    
    @MainActor
    private func registerStores(container: Container) {
        container.register(TimeStore.self) { _ in
            TimeStore()
        }
        .inObjectScope(.container)
        
        container.register(KnowledgeStore.self) { _ in
            KnowledgeStore()
        }
        .inObjectScope(.container)
    }
    
    @MainActor
    private func registerViewModels(container: Container) {
        container.register(PlaceViewModel.self) { (resolver: Resolver, place: Place) in
            PlaceViewModel.make(resolver: resolver, place: place)
        }
    }
}

extension ExpandingWorldAssembly {
    @MainActor static func testing() -> ModuleAssembler {
        ModuleAssembler([ExpandingWorldAssembly()])
    }
}
