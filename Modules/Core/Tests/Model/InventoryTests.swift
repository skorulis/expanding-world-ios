//  Created by Alexander Skorulis on 20/5/2025.

import Core
import Testing

struct InventoryTests {
    
    @Test func addItem() {
        var inventory = Inventory()
        
        inventory.add(.init(type: .grog, amount: 1))
        #expect(inventory.all.count == 1)
        #expect(inventory.all[0].type == .grog)
        #expect(inventory.all[0].amount == 1)
    }
    
    @Test func addMultipleItems() {
        var inventory = Inventory()
        inventory.add(.init(type: .grog, amount: 1))
        inventory.add(.init(type: .leatherArmor, amount: 1))
        
        #expect(inventory.all.count == 2)
        #expect(inventory.count(.grog) == 1)
        #expect(inventory.count(.leatherArmor) == 1)
    }
    
    @Test func addStackableItems() {
        var inventory = Inventory()
        
        inventory.add(.init(type: .stew, amount: 1))
        inventory.add(.init(type: .stew, amount: 2))
        #expect(inventory.all.count == 1)
        #expect(inventory.count(.stew) == 3)
    }
    
    @Test func removeItem() {
        var inventory = Inventory()
        
        inventory.add(.init(type: .leatherArmor, amount: 1))
        inventory.subtract(.init(type: .leatherArmor, amount: 1))
        #expect(inventory.all.isEmpty)
    }
    
    @Test func removePartialStack() {
        var inventory = Inventory()
        
        inventory.add(.init(type: .leatherArmor, amount: 3))
        inventory.subtract(.init(type: .leatherArmor, amount: 1))
        #expect(inventory.all.count == 1)
        #expect(inventory.all[0].amount == 2)
    }
    
    @Test func hasItem() {
        var inventory = Inventory()
        
        #expect(inventory.has(.init(type: .leatherArmor, amount: 1)) == false)
        inventory.add(.init(type: .leatherArmor, amount: 1))
        #expect(inventory.has(.init(type: .leatherArmor, amount: 1)) == true)
    }
    
    @Test func equipItem() {
        var inventory = Inventory()
        inventory.add(.init(type: .leatherArmor, amount: 1))
        
        inventory.equip(.leatherArmor, .body)
        #expect(inventory.equipped(.body)?.type == .leatherArmor)
        #expect(inventory.equipped(.body)?.amount == 1)
        #expect(inventory.count(.leatherArmor) == 0)
    }
    
    @Test func unequipItem() {
        var inventory = Inventory()
        inventory.add(.init(type: .leatherArmor, amount: 1))
        
        inventory.equip(.leatherArmor, .body)
        inventory.unequip(.body)
        
        #expect(inventory.equipped(.body) == nil)
        #expect(inventory.count(.leatherArmor) == 1)
    }
    
    @Test func equipReplacesExisting() {
        var inventory = Inventory()
        inventory.add(.init(type: .leatherArmor, amount: 1))
        inventory.add(.init(type: .robe, amount: 1))
        
        inventory.equip(.leatherArmor, .body)
        inventory.equip(.robe, .body)
        
        #expect(inventory.equipped(.body)?.type == .robe)
        #expect(inventory.count(.leatherArmor) == 1)
        #expect(inventory.count(.robe) == 0)
    }
    
    @Test func unequipEmptySlot() {
        var inventory = Inventory()
        inventory.unequip(.body)
        #expect(inventory.equipped(.body) == nil)
    }
}
    
