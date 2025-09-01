//  Created by Alexander Skorulis on 26/4/2025.

import ASKCore
import Core
import Combine
import Foundation
import Knit

public final class BattlerAssembly: AutoInitModuleAssembly {
    public typealias TargetResolver = BaseResolver
    
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
                playerStore: resolver.battlerRunStore(),
                mainPlayerStore: resolver.playerStore(),
                eventPublisher: resolver.battlerEventPublisher()
            )
        }
        
        container.register(PlayerEquipmentViewModel.self) { resolver in
            PlayerEquipmentViewModel(playerStore: resolver.battlerRunStore())
        }
        
        container.register(BestiaryViewModel.self) { BestiaryViewModel.make(resolver: $0) }
        container.register(CombinedShopViewModel.self) { CombinedShopViewModel.make(resolver: $0) }
        container.register(CharacterEffectsViewModel.self) { CharacterEffectsViewModel.make(resolver: $0) }
        container.register(CharacterAbilitiesViewModel.self) { CharacterAbilitiesViewModel.make(resolver: $0) }
        container.register(SkillDetailsViewModel.self)  { (resolver: BaseResolver, skill: Skill, showPurchase: Bool) in
            SkillDetailsViewModel.make(resolver: resolver, skill: skill, showPurchase: showPurchase)
        }
        
        container.register(GeneralShopViewModel.self) { (
            resolver: BaseResolver,
            shop: BattlerShop
        ) in
            GeneralShopViewModel(
                shop: shop,
                playerStore: resolver.battlerRunStore()
            )
        }
        
        container.register(BattleViewModel.self) { (
            resolver: BaseResolver,
            fight: BattlerFight
        ) in
            BattleViewModel.make(resolver: resolver, fight: fight)
        }
        
        container.register(BattlerMenuViewModel.self) { BattlerMenuViewModel.make(resolver: $0) }
        
        container.register(BestiaryEntryViewModel.self) { (r: BaseResolver, monster: MonsterSpec) in
            BestiaryEntryViewModel.make(resolver: r, monster: monster)
        }
        
        container.register(CharacterViewModel.self) { resolver in
            CharacterViewModel(playerStore: resolver.battlerRunStore())
        }
        
        container.register(MainCharacterViewModel.self) { resolver in
            MainCharacterViewModel.make(resolver: resolver)
        }
        
        container.register(BattlerStatsViewModel.self) { resolver in
            BattlerStatsViewModel.make(resolver: resolver)
        }
        
        container.register(TrainerViewModel.self) { TrainerViewModel.make(resolver: $0) }
        container.register(GameOverViewModel.self) { GameOverViewModel.make(resolver: $0) }
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
        
        // @knit public
        container.register(BattlerStatsMonitor.self) { BattlerStatsMonitor.make(resolver: $0) }
            .inObjectScope(.container)
    }
    
    private func registerStores(container: Container<TargetResolver>) {
        container.register(BattlerRunStore.self) { BattlerRunStore.make(resolver: $0) }
        .inObjectScope(.container)
        
        container.register(BattlerPersistentStore.self) { BattlerPersistentStore.make(resolver: $0) }
    }
    
    public static var dependencies: [any Knit.ModuleAssembly.Type] { [ASKCoreAssembly.self, CoreAssembly.self] }
    
}

public extension BattlerAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<BaseResolver> {
        return ScopedModuleAssembler<BaseResolver>([BattlerAssembly()])
    }
}
