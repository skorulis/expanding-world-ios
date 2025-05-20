//Created by Alexander Skorulis on 16/2/2025.

import Foundation

public struct Inventory: Codable, Sendable {
    private var items: [Item: Int]
    private var slots: [EquipmentSlot: Item.Instance] = [:]
    
    public init(items: [Item.Instance]) {
        self.items = [:]
        for item in items {
            self.add(item)
        }
    }
    
    public init(items: [Item : Int] = [:]) {
        self.items = items
    }
    
    public func count(_ item: Item) -> Int {
        return (items[item] ?? 0)
    }
    
    public func has(_ item: Item.Instance) -> Bool {
        return count(item.type) >= item.amount
    }
    
    public var all: [Item.Instance] {
        return items.keys.map { item in
            return .init(type: item, amount: count(item))
        }
    }
    
    public mutating func add(_ item: Item.Instance) {
        let result = (items[item.type] ?? 0) + item.amount
        items[item.type] = result
    }
    
    public mutating func subtract(_ item: Item.Instance) {
        let count = items[item.type] ?? 0
        guard count >= item.amount else {
            fatalError("Attempt to take more item than you have")
        }
        if item.amount == count {
            items.removeValue(forKey: item.type)
        } else {
            items[item.type] = count - item.amount
        }
    }
    
    public func equipped(_ slot: EquipmentSlot) -> Item.Instance? {
        return slots[slot]
    }
    
    public mutating func equip(_ item: Item, _ slot: EquipmentSlot) {
        unequip(slot)
        subtract(.init(type: item, amount: 1))
        slots[slot] = .init(type: item, amount: 1)
    }
    
    public mutating func unequip(_ slot: EquipmentSlot) {
        if let item = slots[slot] {
            add(item)
            slots.removeValue(forKey: slot)
        }
    }
}

public enum EquipmentSlot: String, Codable, CaseIterable, Sendable {
    case head
    case feet
    case body
}
