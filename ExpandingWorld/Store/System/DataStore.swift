//Created by Alexander Skorulis on 17/2/2025.

import ASKCore
import Core
import Foundation

extension PKeyValueStore {
    
    func set<T: DataStorable>(_ value: T) throws {
        try self.set(codable: value, forKey: T.storageKey.rawValue)
    }
    
    func dataStorable<T: DataStorable>(_ type: T.Type = T.self) -> T {
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

extension Knowledge: DataStorable {
    static var storageKey: DataStoreKey { .knowledge }
    static var defaultValue: Knowledge { .init() }
}

extension Player: DataStorable {
    static var storageKey: DataStoreKey { .player }
}
