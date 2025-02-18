//Created by Alexander Skorulis on 14/2/2025.

import Foundation

final class TimeStore {
    private(set) var seconds: Int64 = 0
    
    private var observers: [() -> Observer?] = []
    
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


