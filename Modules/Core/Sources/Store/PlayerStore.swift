//Created by Alexander Skorulis on 16/2/2025.

import ASKCore
import Combine
import Foundation
import GameSystem
import Knit
import KnitMacros

@Observable public final class PlayerStore {
    
    private let keyValueStore: PKeyValueStore
    private let knowledgeStore: KnowledgeStore
    public var player: Player {
        didSet {
//            if player.statuses.value(.intoxication) >= 5 {
//                knowledgeStore.learn(game: .intoxication)
//            }
//            if player.statuses.value(.satiation) <= 5 {
//                knowledgeStore.learn(game: .satiation)
//            }
//            if player.statuses.value(.health) <= 5 {
//                knowledgeStore.learn(game: .health)
//            }
            try? keyValueStore.set(player)
            playerSubject.send(player)
        }
    }
    
    public var playerSubject: CurrentValueSubject<Player, Never>
    
    @Resolvable<Resolver> @MainActor
    init(keyValueStore: PKeyValueStore, knowledgeStore: KnowledgeStore) {
        self.keyValueStore = keyValueStore
        self.knowledgeStore = knowledgeStore
        let player: Player = keyValueStore.dataStorable()
        self.player = player
        self.playerSubject = .init(player)
    }
    
}

extension Player: DataStorable {
    public static var storageKey: DataStoreKey { .player }
}

//extension PlayerStore: ResettableService {
//    func resetData() {
//        player = .defaultValue
//    }
//}
