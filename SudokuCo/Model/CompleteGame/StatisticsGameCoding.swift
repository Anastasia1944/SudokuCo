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
    
    mutating func configureInfoForSaving(gameName: String) {
        self.gameName = gameName
        self.statsFileName = AllGames().games[gameName]!.statsFileName
    }
    
    func encode(gameStats: GameStatistics) {
        let encoder = JSONEncoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(statsFileName)
            do {
                let jsonData = try encoder.encode(gameStats)
                try jsonData.write(to: fileURL)
            } catch {
                print("Error. Games Statistics Not Saved: \(gameName)")
            }
        }
    }
    
    mutating func decode() -> GameStatistics? {

        let decoder = JSONDecoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(statsFileName)
            do {
                let data = try Data(contentsOf: fileURL)
                return try decoder.decode(GameStatistics.self, from: data)
            } catch {
                print("Error. No Saved Game Statistics: \(gameName)")
            }
        }
        return nil
    }
    
    func deleteGameInfo() {
        
        let fileManager = FileManager.default
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(statsFileName)
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                print("Error. No Game Statistics Info to Delete: \(gameName)")
            }
        }
    }
}
