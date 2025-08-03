//  Created by Alexander Skorulis on 3/8/2025.

import DesignSystem
import SwiftUI

// MARK: - Memory footprint

struct SkillDetailsView {
    @State var viewModel: SkillDetailsViewModel
}

// MARK: - Rendering

extension SkillDetailsView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(title: "\(viewModel.skill.name)")
        } content: {
            content
        }
    }
    
    private var content: some View {
        VStack {
            SkillView(
                skill: viewModel.skill,
                state: viewModel.state
            )
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    SkillDetailsView(
        viewModel: assembler.resolver.skillDetailsViewModel(skill: .unarmed)
    )
}

