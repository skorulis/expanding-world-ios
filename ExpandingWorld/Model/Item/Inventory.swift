//Created by Alexander Skorulis on 16/2/2025.

import Foundation

struct Inventory {
    private var items: [Item: Int]
    
    init(items: [Item.Instance]) {
        self.items = [:]
        for item in items {
            self.add(item)
        }
    }
    
    init(items: [Item : Int] = [:]) {
        self.items = items
    }
    
    func count(_ item: Item) -> Int {
        return (items[item] ?? 0)
    }
    
    var all: [Item.Instance] {
        return items.keys.map { item in
            return .init(type: item, amount: count(item))
        }
    }
    
    mutating func add(_ item: Item.Instance) {
        let result = (items[item.type] ?? 0) + item.amount
        items[item.type] = result
    }
    
    mutating func subtract(_ item: Item.Instance) {
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
}
