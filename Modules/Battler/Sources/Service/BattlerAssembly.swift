//  Created by Alexander Skorulis on 26/4/2025.

import Core
import Foundation
import Knit

public final class BattlerAssembly: AutoInitModuleAssembly {
    public typealias TargetResolver = Resolver
    
    public init() {}
    
    public func assemble(container: Container<TargetResolver>) {
        registerServices(container: container)
        
        container.register(BattlerSequenceViewModel.self) { resolver in
            BattlerSequenceViewModel(generator: resolver.battleStepGenerator())
        }
        
        container.register(BattlerShopViewModel.self) { (
            resolver: Resolver,
            shop: BattlerShop,
            player: BattlerPlayer,
            onFinish: @escaping (BattlerPlayer) -> Void
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
        
        // @knit public
        container.register(BattlerPathRenderer.self) { resolver in
            BattlerPathRenderer(resolver: resolver)
        }
        
        container.register(BattleService.self) { resolver in
            BattleService()
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
    }
    
    public static var dependencies: [any Knit.ModuleAssembly.Type] { [CoreAssembly.self] }
    
}

public extension BattlerAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<Resolver> {
        return ScopedModuleAssembler<Resolver>([BattlerAssembly()])
    }
}
