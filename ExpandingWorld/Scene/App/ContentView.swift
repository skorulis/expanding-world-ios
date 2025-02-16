//  Created by Alexander Skorulis on 14/2/2025.

import SwiftUI

struct ContentView: View {
    
    @State var viewModel: ContentViewModel
    @Environment(\.resolver) private var resolver
    
    var body: some View {
        MainTabsView(knowledgeStore: resolver.knowledgeStore())
    }
    
}

#Preview {
    let assembler = ExpandingWorldAssembly.testing()
    ContentView(viewModel: assembler.resolver.contentViewModel())
}
