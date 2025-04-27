//  Created by Alexander Skorulis on 27/4/2025.

import Core
import ASKCoordinator
import Foundation
import SwiftUI

enum BattlerPath: CoordinatorPath {
    case sequence
    case battle(BattlerFight)
    
    var id: String {
        switch self {
        case .sequence:
            return "battler.sequence"
        case let .battle(fight):
            return "battle-\(fight.id)"
        }
    }
}

struct BattlerPathRenderer: CoordinatorPathRenderer {
    
    private let resolver: AppResolver
    
    @ViewBuilder
    func render(path: BattlerPath, in coordinator: Coordinator) -> some View {
        switch path {
        case .sequence:
            BattlerSequenceView(viewModel: Self.apply(resolver.battlerSequenceViewModel(), coordinator))
        case let .battle(fight):
            BattleView(viewModel: resolver.battleViewModel(fight: fight))
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
