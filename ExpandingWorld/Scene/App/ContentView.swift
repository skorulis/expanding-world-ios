//  Created by Alexander Skorulis on 14/2/2025.

import ASKCoordinator
import Battler
import Knit
import SwiftUI

struct ContentView: View {
    @Environment(\.resolver) private var resolver
    @State var viewModel: ContentViewModel
    @State var coordinator = Coordinator(root: BattlerPath.menu)
    
    var body: some View {
        CoordinatorView(coordinator: coordinator)
            .with(renderer: resolver!.battlerPathRenderer())
    }
}
