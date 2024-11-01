//
//  StoreManager.swift
//  DiceRoll
//
//  Created by Galih Samudra on 01/11/24.
//

import Foundation

enum Config {
    static let SAVE_PATH = URL.documentsDirectory.appending(path: "SavedDices")
}

struct DiceResult: Codable, Identifiable  {
    var id = UUID()
    var selectedSides: Int
    var totalRoledDice: Int
    var resultRoledDice: [Int] = [0]
    
    static let example = DiceResult(selectedSides: 4, totalRoledDice: 0)
}

protocol iStorageManager {
    func load() -> DiceResult?
    func save(_ result: DiceResult)
}

struct StorageManager: iStorageManager {
    func load() -> DiceResult? {
        do {
            let data = try Data(contentsOf: Config.SAVE_PATH)
            return try JSONDecoder().decode(DiceResult.self, from: data)
        } catch {
            return nil
        }
    }
    
    func save(_ result: DiceResult) {
        do {
            let data = try JSONEncoder().encode(result)
            try data.write(to: Config.SAVE_PATH, options: [.atomic, .completeFileProtection])
        } catch {
            print("error -- \(error.localizedDescription)")
        }
    }
}
