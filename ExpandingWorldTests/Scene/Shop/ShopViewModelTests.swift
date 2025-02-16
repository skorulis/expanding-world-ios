//Created by Alexander Skorulis on 16/2/2025.

import Testing
@testable import ExpandingWorld

@MainActor
struct ShopViewModelTests {
    
    private let assembler = ExpandingWorldAssembly.testing()
    
    @Test func buy() {
        let viewModel = assembler.resolver.shopViewModel(shopID: .pinkyTavern)
        let playerStore = assembler.resolver.playerStore()
        viewModel.buy(item: .init(type: .grog, amount: 10))
        #expect(playerStore.player.inventory.count(.grog) == 10)
        #expect(viewModel.shop.inventory.count(.grog) == 90)
        #expect(playerStore.player.money == 80)
    }
}
