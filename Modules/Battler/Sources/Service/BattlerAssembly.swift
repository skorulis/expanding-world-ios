//  Created by Alexander Skorulis on 26/4/2025.

import ASKCore
import Core
import Foundation
import Knit

public final class BattlerAssembly: AutoInitModuleAssembly {
    public typealias TargetResolver = Resolver
    
    public init() {}
    
    public func assemble(container: Container<TargetResolver>) {
        registerServices(container: container)
        registerViewModels(container: container)
        
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
            BattlerSequenceViewModel(generator: resolver.battleStepGenerator())
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
                onFinish: { _ in }
            )
        }
        
        container.register(BattleViewModel.self) { (
            resovler: Resolver,
            player: BattlerPlayer,
            fight: BattlerFight,
            resultHandler: @escaping BattlerFight.ResultHandler
        ) in
            BattleViewModel(player: player, fight: fight, resultHandler: resultHandler)
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
