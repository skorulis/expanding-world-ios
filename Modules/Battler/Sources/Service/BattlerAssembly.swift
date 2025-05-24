//  Created by Alexander Skorulis on 26/4/2025.

import ASKCore
import Core
import Combine
import Foundation
import Knit

public final class BattlerAssembly: AutoInitModuleAssembly {
    public typealias TargetResolver = Resolver
    
    public init() {}
    
    public func assemble(container: Container<TargetResolver>) {
        registerServices(container: container)
        registerViewModels(container: container)
        
        container.register(PassthroughSubject<BattlerEvent, Never>.self) { _ in
            PassthroughSubject()
        }
        .inObjectScope(.container)
        
        container.register(AnyPublisher<BattlerEvent, Never>.self) { resolver in
            resolver.battlerEventSubject().eraseToAnyPublisher()
        }
        
        // @knit public
        container.register(BattlerPathRenderer.self) { resolver in
            BattlerPathRenderer(resolver: resolver)
        }
        
        container.register(BattlerPlayerStore.self) { _ in
            BattlerPlayerStore(player: .testPlayer())
        }
        .inObjectScope(.container)
    }
    
    private func registerViewModels(container: Container<TargetResolver>) {
        container.register(BattlerSequenceViewModel.self) { resolver in
            BattlerSequenceViewModel(
                generator: resolver.battleStepGenerator(),
                eventPublisher: resolver.battlerEventPublisher()
            )
        }
        
        container.register(PlayerEquipmentViewModel.self) { resolver in
            PlayerEquipmentViewModel(playerStore: resolver.battlerPlayerStore())
        }
        
        container.register(BattlerShopViewModel.self) { (
            resolver: Resolver,
            shop: BattlerShop
        ) in
            BattlerShopViewModel(
                shop: shop,
                playerStore: resolver.battlerPlayerStore(),
                eventPublisher: resolver.battlerEventSubject()
            )
        }
        
        container.register(BattleViewModel.self) { (
            resolver: Resolver,
            fight: BattlerFight
        ) in
            BattleViewModel(
                fight: fight,
                playerStore: resolver.battlerPlayerStore(),
                eventPublisher: resolver.battlerEventSubject()
            )
        }
        
        container.register(BattlerMenuViewModel.self) { resolver in
            BattlerMenuViewModel(playerStore: resolver.battlerPlayerStore())
        }
    }
    
    private func registerServices(container: Container<TargetResolver>) {
        container.register(BattleFightFactory.self) { _ in
            BattleFightFactory()
        }
        
        container.register(BattleShopFactory.self) { _ in
            BattleShopFactory()
        }
        
        container.register(BattleStepGenerator.self) { resolver in
            BattleStepGenerator(
                fightFactory: resolver.battleFightFactory(),
                shopFactory: resolver.battleShopFactory()
            )
        }
        
        container.register(BattleService.self) { resolver in
            BattleService()
        }
    }
    
    public static var dependencies: [any Knit.ModuleAssembly.Type] { [ASKCoreAssembly.self, CoreAssembly.self] }
    
}

public extension BattlerAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<Resolver> {
        return ScopedModuleAssembler<Resolver>([BattlerAssembly()])
    }
}
