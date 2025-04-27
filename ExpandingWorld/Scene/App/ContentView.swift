//  Created by Alexander Skorulis on 14/2/2025.

import ASKCoordinator
import Battler
import Knit
import SwiftUI

struct ContentView: View {
    @Environment(\.resolver) private var resolver
    @State var viewModel: ContentViewModel
    @State var coordinator = Coordinator(root: BattlerPath.sequence)
    
    var body: some View {
        CoordinatorView(coordinator: coordinator)
            .with(renderer: resolver!.battlerPathRenderer())
    }
}


//struct ContentView: View {
//    
//    @State var viewModel: ContentViewModel
//    @Environment(\.resolver) private var resolver
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            GameStatusBar(viewModel: resolver!.gameStatusBarViewModel())
//            MainTabsView(knowledgeStore: resolver!.knowledgeStore())
//        }
//        .ignoresSafeArea(edges: .top)
//    }
//    
//}
//
//#Preview {
//    let assembler = ExpandingWorldAssembly.testing()
//    ContentView(viewModel: assembler.resolver.contentViewModel())
//}
