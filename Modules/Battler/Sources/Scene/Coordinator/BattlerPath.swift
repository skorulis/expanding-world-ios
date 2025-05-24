//  Created by Alexander Skorulis on 27/4/2025.

import Knit
import ASKCoordinator
import Foundation
import SwiftUI

public enum BattlerPath: CoordinatorPath {
    case sequence
    case equipment
    case shop(BattlerShop)
    case battle(BattlerPlayer, BattlerFight, BattlerFight.ResultHandler)
    
    public var id: String {
        switch self {
        case .sequence:
            return "battler.sequence"
        case let .battle(_, fight, _):
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
        case .equipment:
            PlayerEquipmentView(viewModel: resolver.playerEquipmentViewModel())
        case .sequence:
            BattlerSequenceView(viewModel: Self.apply(resolver.battlerSequenceViewModel(), coordinator))
        case let .shop(shop):
            ShopView(viewModel: resolver.battlerShopViewModel(shop: shop))
        case let .battle(player, fight, resultHandler):
            BattleView(
                viewModel: Self.apply(
                    resolver.battleViewModel(player: player, fight: fight, resultHandler: resultHandler),
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
