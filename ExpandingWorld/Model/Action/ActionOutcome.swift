//Created by Alexander Skorulis on 22/2/2025.

import Foundation

/// Something that can happen in response to taking an action
enum ActionOutcome {
    
    /// Show an alert to the user
    case alert(String)
}


struct ActionPossibilities {
    
    let conditionals: [ActionConditional]
    
    /// Fallback outcome when no conditionals are matched
    let fallback: [ActionOutcome]
}

struct ActionConditional {
    
    // TODO: Add type for condition
    let outcomes: [ActionOutcome]
}
