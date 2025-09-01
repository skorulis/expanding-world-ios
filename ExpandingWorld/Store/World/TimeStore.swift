//Created by Alexander Skorulis on 14/2/2025.

import ASKCore
import Core
import GameSystem
import Foundation
import Knit
import KnitMacros

final class TimeStore: ObservableObject {
    @Published private(set) var seconds: Int64 {
        didSet {
            try! keyValueStore.set(Time(seconds: seconds))
        }
    }
    private var observers: [() -> Observer?] = []
    
    private let keyValueStore: PKeyValueStore
    
    @Resolvable<BaseResolver>
    init(keyValueStore: PKeyValueStore) {
        self.keyValueStore = keyValueStore
        self.seconds = keyValueStore.dataStorable(Time.self).seconds
    }
    
    func advance(seconds: Int64) {
        self.seconds += seconds
        for observer in observers {
            observer()?.timeAdvanced(seconds: seconds)
        }
    }
    
    func addObserver(_ observer: any Observer) {
        observers.append({ [weak observer] in observer })
    }
}

extension TimeStore {

    protocol Observer: AnyObject {
        func timeAdvanced(seconds: Int64)
    }

    struct Time: Codable, DataStorable {
        
        var seconds: Int64
        static var storageKey: DataStoreKey { .time }
        static var defaultValue: TimeStore.Time { .init(seconds: 0) }
        
        
    }
}


