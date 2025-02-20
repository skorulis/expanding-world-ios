//Created by Alexander Skorulis on 20/2/2025.

import Foundation

protocol ResettableService {
    func resetData()
}

typealias ResettableServiceProvider = () -> [ResettableService]
