//  Created by Alexander Skorulis on 27/4/2025.

import Knit
import ASKCoordinator
import Foundation
import SwiftUI

public enum BattlerPath: CoordinatorPath {
    case menu
    case character
    case sequence
    case equipment
    case shop(BattlerShop)
    case battle(BattlerFight)
    case bestiary
    
    public var id: String {
        switch self {
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
        case .shop:
            return "shop"
        case .bestiary:
            return "battler.bestiary"
        }
    }
}

public struct BattlerPathRenderer: CoordinatorPathRenderer {
    
    let resolver: Resolver
    
    @ViewBuilder
    public func render(path: BattlerPath, in coordinator: Coordinator) -> some View {
        switch path {
        case .menu:
            BattlerMenuView(viewModel: Self.apply(resolver.battlerMenuViewModel(), coordinator))
        case .character:
            CharacterView(viewModel: resolver.characterViewModel())
        case .equipment:
            PlayerEquipmentView(viewModel: resolver.playerEquipmentViewModel())
        case .sequence:
            BattlerSequenceView(viewModel: Self.apply(resolver.battlerSequenceViewModel(), coordinator))
        case let .shop(shop):
            ShopView(viewModel: Self.apply(resolver.battlerShopViewModel(shop: shop), coordinator))
        case let .battle(fight):
            BattleView(
                viewModel: Self.apply(
                    resolver.battleViewModel(fight: fight),
                    coordinator
                )
            )
        case .bestiary:
            BestiaryView(viewModel: Self.apply(resolver.bestiaryViewModel(), coordinator))
        }
    }
    
    static func apply<Obj>(_ obj: Obj, _ coordinator: Coordinator) -> Obj {
        (obj as? CoordinatorViewModel)?.coordinator = coordinator
        return obj
    }
}

protocol CoordinatorViewModel: AnyObject {
    var coordinator: Coordinator? { get set }
}
