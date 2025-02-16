//Created by Alexander Skorulis on 16/2/2025.

import Testing
@testable import ExpandingWorld

struct InventoryTests {
 
    @Test func add() {
        var inventory = Inventory()
        #expect(inventory.all.count == 0)
        inventory.add(.init(type: .grog, amount: 10))
        #expect(inventory.count(.grog) ==  10)
        inventory.add(.init(type: .grog, amount: 15))
        #expect(inventory.count(.grog) ==  25)
    }
    
    @Test func subtract() {
        var inventory = Inventory()
        inventory.add(.init(type: .stew, amount: 10))
        inventory.subtract(.init(type: .stew, amount: 5))
        #expect(inventory.count(.stew) ==  5)
        inventory.subtract(.init(type: .stew, amount: 5))
        #expect(inventory.count(.stew) ==  0)
        #expect(inventory.all.count == 0)
    }
}
