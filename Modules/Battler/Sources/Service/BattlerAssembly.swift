//  Created by Alexander Skorulis on 26/4/2025.

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
        
        container.register(PlayerStore.self) { _ in
            PlayerStore(player: .testPlayer())
        }
        .inObjectScope(.container)
    }
    
    private func registerViewModels(container: Container<TargetResolver>) {
        container.register(BattlerSequenceViewModel.self) { resolver in
            BattlerSequenceViewModel(generator: resolver.battleStepGenerator())
        }
        
        container.register(PlayerEquipmentViewModel.self) { resolver in
            PlayerEquipmentViewModel(playerStore: resolver.playerStore())
        }
        
        container.register(BattlerShopViewModel.self) { (
            resolver: Resolver,
            shop: BattlerShop,
            player: BattlerPlayer,
            onFinish: @escaping BattlerPlayer.ChangeHandler
        ) in
            BattlerShopViewModel(shop: shop, player: player, onFinish: onFinish)
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
    
    public static var dependencies: [any Knit.ModuleAssembly.Type] { [CoreAssembly.self] }
    
}

public extension BattlerAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<Resolver> {
        return ScopedModuleAssembler<Resolver>([BattlerAssembly()])
    }
}
