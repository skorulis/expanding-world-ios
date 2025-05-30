//Created by Alexander Skorulis on 1/3/2025.

import Core
import Foundation
import Hex
import SwiftUI

@Observable final class ContentViewModel {
    var map = GameMap(width: 10, height: 10, tiles: nil)
    
    var selected: HexagonGrid.Coord?
    private var fileName: URL?
    var mode: EditMode = .paint
    
    var paintTexture: GameMap.TerrainType? = nil
    
    init() {}
}

extension ContentViewModel {
    
    var grid: HexagonGrid {
        map.grid
    }
    
    func maybePaint(coord: HexagonGrid.Coord) {
        guard mode == .paint else { return }
        var tile = map.tiles[coord.y][coord.x]
        if tile.terrain != paintTexture {
            tile.terrain = paintTexture
            map.tiles[coord.y][coord.x] = tile
        }
    }
    
    func saveMap() {
        let panel = NSSavePanel()
        panel.allowedContentTypes = [.json]
        panel.canCreateDirectories = true
        panel.title = "Save JSON File"
        
        if panel.runModal() == .OK, let url = panel.url {
            do {
                let jsonContent = try JSONEncoder().encode(map)
                try jsonContent.write(to: url)
                print("File saved at new location")
            } catch {
                print("Failed to save: \(error)")
            }
        }
    }
    
    func openFile() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.json]
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.canCreateDirectories = true
        
        if panel.runModal() == .OK, let url = panel.url {
            do {
                let data = try Data(contentsOf: url)
                self.map = try JSONDecoder().decode(GameMap.self, from: data)
                self.map.updateFeatureConnections()
                self.fileName = url
            } catch {
                print("Failed to load JSON, \(error)")
            }
        }
    }
}

extension ContentViewModel {
    enum EditMode: Hashable, Identifiable, CaseIterable {
        case paint, single
        
        var id: Self { self }
    }
}
