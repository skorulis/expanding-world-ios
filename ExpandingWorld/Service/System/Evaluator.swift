//Created by Alexander Skorulis on 23/2/2025.

import Foundation
import Knit
import KnitMacros

final class Evaluator {
    
    private let playerStore: PlayerStore
    
    @Resolvable<Resolver>
    init(playerStore: PlayerStore) {
        self.playerStore = playerStore
    }
    
    func evaluate(_ expression: NumericExpression) -> Double {
        expression.evaluate(
            .init(status: { Double(self.playerStore.player.statuses.value($0)) })
        )
    }
}
