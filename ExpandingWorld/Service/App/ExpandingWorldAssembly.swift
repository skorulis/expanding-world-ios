//Created by Alexander Skorulis on 14/2/2025.

import ASKCore
import Battler
import Foundation
import Knit

final class ExpandingWorldAssembly: AutoInitModuleAssembly {
    typealias TargetResolver = Resolver
    static var dependencies: [any Knit.ModuleAssembly.Type] = [
        ASKCoreAssembly.self,
        BattlerAssembly.self,
    ]
    
    init() {}
    
    @MainActor func assemble(container: Container<Resolver>) {
        registerBehaviors(container: container)
        registerServices(container: container)
        registerStores(container: container)
        registerViewModels(container: container)
    }
    
    @MainActor
    private func registerServices(container: Container<Resolver>) {
        container.register(ActionService.self) { r in
            ActionService.make(resolver: r)
        }
        
        container.register(Evaluator.self) { Evaluator.make(resolver: $0) }
        container.register(AlertService.self) { _ in AlertService() }
            .inObjectScope(.container)
        
        container.register(GameService.self) { r in GameService.make(resolver: r) }
        
        container.register(PlayerStatusService.self) { PlayerStatusService.make(resolver: $0) }
            .inObjectScope(.container)
    }
    
    @MainActor
    private func registerStores(container: Container<Resolver>) {
        container.register(TimeStore.self) { TimeStore.make(resolver: $0) }
            .inObjectScope(.container)
        
        container.register(KnowledgeStore.self) { KnowledgeStore.make(resolver: $0) }
            .inObjectScope(.container)
        
        container.register(ShopStore.self) { ShopStore.make(resolver: $0) }
            .inObjectScope(.container)
        
        container.register(PlayerStore.self) { PlayerStore.make(resolver: $0) }
            .inObjectScope(.container)
    }
    
    @MainActor
    private func registerViewModels(container: Container<Resolver>) {
        container.register(PlaceViewModel.self) { (resolver: Resolver, place: Place) in
            PlaceViewModel.make(resolver: resolver, place: place)
        }
        
        container.register(PlaceContainerViewModel.self) { PlaceContainerViewModel.make(resolver: $0) }
        container.register(ContentViewModel.self) { ContentViewModel.make(resolver: $0) }
        container.register(PlayerInventoryViewModel.self) { PlayerInventoryViewModel.make(resolver: $0) }
        container.register(PlayerStatusViewModel.self) { PlayerStatusViewModel.make(resolver: $0) }
        container.register(SettingsViewModel.self) { SettingsViewModel.make(resolver: $0) }
        container.register(GameStatusBarViewModel.self) { GameStatusBarViewModel.make(resolver: $0) }
        
        container.register(ShopViewModel.self) { (resolver: Resolver, shopID: ShopID) in
            ShopViewModel.make(resolver: resolver, shopID: shopID)
        }
    }
    
    private func registerBehaviors(container: Container<Resolver>) {
//        container.register(InstanceAggregation<ResettableService>.self, name: "resettableService") { _ in
//            .init(isChild: { $0 is ResettableService.Type })
//        }
//        .inObjectScope(.container)
//        
//        container.addBehavior(container.instanceAggregation(name: .resettableService))

        container.register(ResettableServiceProvider.self) { resolver in
            return { [] }
        }
    }
}

extension ExpandingWorldAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<Resolver> {
        ScopedModuleAssembler<Resolver>([ExpandingWorldAssembly(), ASKCoreAssembly(purpose: .testing)])
    }
}
