//  Created by Alexander Skorulis on 27/4/2025.

import Knit
import ASKCoordinator
import Foundation
import SwiftUI

public enum BattlerPath: CoordinatorPath {
    case menu
    case sequence
    case equipment
    case shop(BattlerShop)
    case battle(BattlerFight)
    
    public var id: String {
        switch self {
        case .menu:
            return "menu"
        case .sequence:
            return "battler.sequence"
        case let .battle(fight):
            return "battle-\(fight.id)"
        case .equipment:
            return "battler.equipment"
        case .shop:
            return "shop"
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
