//  Created by Alexander Skorulis on 27/4/2025.

import ASKCore
import Foundation

public extension PKeyValueStore {
    
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

public protocol DataStorable: Codable {
    static var storageKey: DataStoreKey { get }
    static var defaultValue: Self { get }
}

public enum DataStoreKey: String, CaseIterable {
    case player
    case battlerStats
    case knowledge
    case shops
    case time
}
