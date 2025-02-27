//Created by Alexander Skorulis on 22/2/2025.

import Foundation

/// Something that can happen in response to taking an action
enum ActionOutcome {
    
    /// Show an alert to the user
    case alert(String)
    
    /// Time advances by x seconds
    case time(Int64)
}


struct ActionPossibilities {
    
    let conditionals: [ActionConditional]
    
    /// Fallback outcome when no conditionals are matched
    let fallback: [ActionOutcome]
    
    static func fixed(_ outcomes: [ActionOutcome]) -> Self {
        .init(conditionals: [], fallback: outcomes)
    }
}

struct ActionConditional {
    
    let condition: NumericExpression
    let outcomes: [ActionOutcome]
    
    init(@ExpressionBuilder condition: () -> NumericExpression, outcomes: [ActionOutcome]) {
        self.condition = condition()
        self.outcomes = outcomes
    }
}
