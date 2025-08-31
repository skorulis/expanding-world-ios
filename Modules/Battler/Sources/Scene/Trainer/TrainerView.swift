//  Created by Alexander Skorulis on 30/8/2025.

import DesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct TrainerView {
    @State var viewModel: TrainerViewModel
}

// MARK: - Rendering

extension TrainerView: View {
    
    var body: some View {
        PageLayout {
            TitleBar(
                title: "Trainer",
                backAction: { viewModel.coordinator?.pop() },
                trailing: {
                    TrailingBarButtons(
                        money: viewModel.player.money,
                        coordinator: viewModel.coordinator
                    )
                }
            )
        } content: {
            content
        }
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            pageSelector
            switch viewModel.page {
            case .skills:
                skillsView
            case .talents:
                talentsView
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var pageSelector: some View {
        Picker(selection: $viewModel.page) {
            ForEach(Page.allCases, id: \.self) { item in
                Text(item.rawValue)
            }
        } label: {
            Text("")
        }
        .pickerStyle(.segmented)
    }
    
    private var skillsView: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.availableSkills) { skill in
                Button(action: { viewModel.show(skill: skill) }) {
                    TrainerSkillCell(skill: skill)
                }
            }
        }
    }
    
    private var talentsView: some View {
        VStack(spacing: 0) {
            
        }
    }
    
}

extension TrainerView {
    enum Page: String, CaseIterable, Identifiable {
        case skills, talents
        
        var id: Self { self }
    }
}

// MARK: - Previews

#Preview {
    let assembler = BattlerAssembly.testing()
    TrainerView(viewModel: assembler.resolver.trainerViewModel())
}

