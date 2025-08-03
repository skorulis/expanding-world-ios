//  Created by Alexander Skorulis on 27/4/2025.

import Core
import Knit
import ASKCoordinator
import Foundation
import SwiftUI

public enum BattlerPath: CoordinatorPath {
    case menu
    case mainCharacter
    case character
    case characterEffects
    case sequence
    case equipment
    case shop(BattlerShop)
    case battle(BattlerFight)
    case bestiary
    case stats
    case gameOver
    case bestiaryEntry(MonsterSpec)
    case skillDetails(Skill)
    
    public var id: String {
        switch self {
        case .mainCharacter:
            return "mainCharacter"
        case .characterEffects:
            return "characterEffects"
        case .menu:
            return "menu"
        case .character:
            return "character"
        case .sequence:
            return "battler.sequence"
        case let .battle(fight):
            return "battle-\(fight.id)"
        case .equipment:
            return "battler.equipment"
        case let .shop(shop):
            return "shop-\(shop.spec.name)"
        case .bestiary:
            return "battler.bestiary"
        case .stats:
            return "stats"
        case .gameOver:
            return "gameOver"
        case let .bestiaryEntry(monster):
            return "bestiary.entry.\(monster.id)"
        case let .skillDetails(skill):
            return "skill.details.\(skill.name)"
        }
    }
}

public struct BattlerPathRenderer: CoordinatorPathRenderer {
    
    let resolver: Resolver
    
    @ViewBuilder
    public func render(path: BattlerPath, in coordinator: Coordinator) -> some View {
        switch path {
        case .menu:
            BattlerMenuView(viewModel: coordinator.apply(resolver.battlerMenuViewModel()))
        case .mainCharacter:
            MainCharacterView(viewModel: coordinator.apply(resolver.mainCharacterViewModel()))
        case .character:
            CharacterView(viewModel: coordinator.apply(resolver.characterViewModel()))
        case .characterEffects:
            CharacterEffectsView(viewModel: coordinator.apply(resolver.characterEffectsViewModel()))
        case .equipment:
            PlayerEquipmentView(viewModel: coordinator.apply(resolver.playerEquipmentViewModel()))
        case .sequence:
            BattlerSequenceView(viewModel: coordinator.apply(resolver.battlerSequenceViewModel()))
        case let .shop(shop):
            ShopView(viewModel: coordinator.apply(resolver.battlerShopViewModel(shop: shop)))
        case let .battle(fight):
            BattleView(
                viewModel: coordinator.apply(
                    resolver.battleViewModel(fight: fight)
                )
            )
        case .bestiary:
            BestiaryView(viewModel: Self.apply(resolver.bestiaryViewModel(), coordinator))
        case let .bestiaryEntry(monster):
            BestiaryEntryView(viewModel: Self.apply(resolver.bestiaryEntryViewModel(monster: monster), coordinator))
        case .stats:
            BattlerStatsView(viewModel: Self.apply(resolver.battlerStatsViewModel(), coordinator))
        case .gameOver:
            GameOverView(viewModel: Self.apply(resolver.gameOverViewModel(), coordinator))
        case let .skillDetails(skill):
            SkillDetailsView(viewModel: Self.apply(resolver.skillDetailsViewModel(skill: skill), coordinator))
        }
    }
    
    static func apply<Obj>(_ obj: Obj, _ coordinator: Coordinator) -> Obj {
        (obj as? CoordinatorViewModel)?.coordinator = coordinator
        return obj
    }
}

private extension Coordinator {
    func apply<Obj>(_ obj: Obj) -> Obj {
        (obj as? CoordinatorViewModel)?.coordinator = self
        return obj
    }
}

protocol CoordinatorViewModel: AnyObject {
    var coordinator: Coordinator? { get set }
}
