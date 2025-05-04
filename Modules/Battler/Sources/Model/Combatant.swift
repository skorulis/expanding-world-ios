//  Created by Alexander Skorulis on 4/5/2025.

import Foundation

protocol Combatant {
    var id: UUID { get }
    var health: Int { get set }
    var ability: AttackAbility { get }
}
