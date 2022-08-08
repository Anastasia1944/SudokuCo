//
//  StatisticsGameCoding.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 08.07.2022.
//

import Foundation

struct StatisticGameCoding {
    private var statsFileName: String = ""
    private var gameName: String = ""
    private var gameLevel: String = ""
    
    private var levels: [String] = ["Easy", "Medium", "Hard", "Expert"]
    
    mutating func configureInfoForSaving(gameName: String, level: String) {
        self.gameName = gameName
        self.statsFileName = AllGames().games[gameName]!.statsFileName
        self.gameLevel = level
    }
    
    mutating func encode(gameStats: GameStatistics) {
        let encoder = JSONEncoder()
        
        let currentFilePath = statsFileName + gameLevel
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(currentFilePath)
            do {
                let jsonData = try encoder.encode(gameStats)
                try jsonData.write(to: fileURL)
            } catch {
                print("Error. Games Statistics Not Saved: \(gameName), level: \(gameLevel)")
            }
        }
    }
    
    mutating func decode() -> GameStatistics? {
        let decoder = JSONDecoder()
        
        let currentFilePath = statsFileName + gameLevel
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(currentFilePath)
            do {
                let data = try Data(contentsOf: fileURL)
                return try decoder.decode(GameStatistics.self, from: data)
            } catch {
                print("Error. No Saved Game Statistics: \(gameName), level: \(gameLevel)")
            }
        }
        return nil
    }
    
    func deleteGameInfo() {
        
        let fileManager = FileManager.default
        
        for level in levels {
            let currentFilePath = statsFileName + level
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(currentFilePath)
                do {
                    try fileManager.removeItem(at: fileURL)
                } catch {
                    print("Error. No Game Statistics Info to Delete: \(gameName)")
                }
            }
        }
    }
}
