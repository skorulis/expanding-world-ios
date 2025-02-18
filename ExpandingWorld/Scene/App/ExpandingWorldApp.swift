//  Created by Alexander Skorulis on 14/2/2025.

import ASKCore
import SwiftUI
import Knit

@main
struct ExpandingWorldApp: App {
    
    private let assembler: ModuleAssembler = {
        let assembler = ModuleAssembler([
            ExpandingWorldAssembly(),
            ASKCoreAssembly(purpose: .normal),
        ])
        assembler.resolver.gameService().startNewGame()
        return assembler
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: assembler.resolver.contentViewModel())
                .environment(\.resolver, assembler.resolver)
                .onAppear {
                    startup()
                }
        }
    }
    
    private func startup() {
        assembler.resolver.alertService().window = .init()
        _ = assembler.resolver.playerStatusService()
    }
}
