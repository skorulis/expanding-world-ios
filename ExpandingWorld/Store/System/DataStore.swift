//Created by Alexander Skorulis on 17/2/2025.

import ASKCore
import Foundation

extension PKeyValueStore {
    
    func set<T: DataStorable>(_ value: T) throws {
        try self.set(codable: value, forKey: T.storageKey.rawValue)
    }
    
    func dataStorable<T: DataStorable>() -> T {
        return (try? self.codable(forKey: T.storageKey.rawValue)) ?? .defaultValue
    }
    
    func clearDataStore() {
        for key in DataStoreKey.allCases {
            self.removeObject(forKey: key.rawValue)
        }
    }
}

protocol DataStorable: Codable {
    static var storageKey: DataStoreKey { get }
    static var defaultValue: Self { get }
}

enum DataStoreKey: String, CaseIterable {
    case player
    case knowledge
    case shops
    case time
}
