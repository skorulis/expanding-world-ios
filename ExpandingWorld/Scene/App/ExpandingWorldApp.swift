//  Created by Alexander Skorulis on 14/2/2025.

import ASKCore
import SwiftUI
import Knit

@main
struct ExpandingWorldApp: App {
    
    private let assembler: ModuleAssembler = {
        let assembler = ModuleAssembler(
            [
                ExpandingWorldAssembly(),
                ASKCoreAssembly(purpose: .normal),
            ]
        )
        assembler.resolver.gameService().setup()
        return assembler
    }()
    
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .top) {
                ContentView(viewModel: assembler.resolver.contentViewModel())
                    .environment(\.resolver, assembler.resolver)
                    .onAppear {
                        startup()
                    }
                GameStatusBar(viewModel: assembler.resolver.gameStatusBarViewModel())
            }
            .statusBar(hidden: true)
        }
    }
    
    private func startup() {
        assembler.resolver.alertService().window = .init()
        _ = assembler.resolver.playerStatusService()
    }
}
