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
        registerStores(container: container)
        
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
    }
    
    private func registerViewModels(container: Container<TargetResolver>) {
        container.register(BattlerSequenceViewModel.self) { resolver in
            BattlerSequenceViewModel(
                generator: resolver.battleStepGenerator(),
                playerStore: resolver.battlerPlayerStore(),
                mainPlayerStore: resolver.playerStore(),
                eventPublisher: resolver.battlerEventPublisher()
            )
        }
        
        container.register(PlayerEquipmentViewModel.self) { resolver in
            PlayerEquipmentViewModel(playerStore: resolver.battlerPlayerStore())
        }
        
        container.register(BestiaryViewModel.self) { BestiaryViewModel.make(resolver: $0) }
        container.register(CharacterEffectsViewModel.self) { CharacterEffectsViewModel.make(resolver: $0) }
        
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
            BattleViewModel.make(resolver: resolver, fight: fight)
        }
        
        container.register(BattlerMenuViewModel.self) { resolver in
            BattlerMenuViewModel(
                playerStore: resolver.battlerPlayerStore(),
                mainPlayerStore: resolver.playerStore(),
                persistentStore: resolver.battlerPersistentStore()
            )
        }
        
        container.register(BestiaryEntryViewModel.self) { (r: Resolver, monster: MonsterSpec) in
            BestiaryEntryViewModel.make(resolver: r, monster: monster)
        }
        
        container.register(CharacterViewModel.self) { resolver in
            CharacterViewModel(playerStore: resolver.battlerPlayerStore())
        }
        
        container.register(MainCharacterViewModel.self) { resolver in
            MainCharacterViewModel()
        }
        
        container.register(BattlerStatsViewModel.self) { resolver in
            BattlerStatsViewModel.make(resolver: resolver)
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
    
    private func registerStores(container: Container<TargetResolver>) {
        container.register(BattlerPlayerStore.self) { _ in
            BattlerPlayerStore(player: .testPlayer())
        }
        .inObjectScope(.container)
        
        container.register(BattlerPersistentStore.self) { BattlerPersistentStore.make(resolver: $0) }
    }
    
    public static var dependencies: [any Knit.ModuleAssembly.Type] { [ASKCoreAssembly.self, CoreAssembly.self] }
    
}

public extension BattlerAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<Resolver> {
        return ScopedModuleAssembler<Resolver>([BattlerAssembly()])
    }
}
