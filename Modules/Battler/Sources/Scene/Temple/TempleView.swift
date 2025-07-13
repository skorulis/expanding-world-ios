//  Created by Alexander Skorulis on 12/7/2025.

import DesignSystem
import Foundation
import SwiftUI

@MainActor
struct TempleView: View {
    @State var viewModel: TempleViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            TitleBar(
                title: viewModel.temple.name
            )
            buffList
        }
        .navigationBarHidden(true)
    }
    
    private var buffList: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.temple.buffs) { buff in
                    Button(action: { viewModel.buy(item: buff) }) {
                        TempleBuffView(item: buff)
                    }
                }
            }
        }
    }
    
}

#Preview {
    let assembler = BattlerAssembly.testing()
    let resolver = assembler.resolver
    TempleView(
        viewModel: resolver.templeViewModel(
            temple: .init(spec: .light)
        )
    )
}
