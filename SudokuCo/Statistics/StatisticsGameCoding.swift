//
//  StatisticsGameCoding.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 08.07.2022.
//

import Foundation

struct StatisticGameCoding {
    
    func saveGameStatistics(gameStats: GameStatistics) {
        let gameName = gameStats.gameName
        let gameLevel = DifficultyLevelsStringToEnum().getDifficultyLevelStringByEnum(level: gameStats.gameLevel)
        let statsFileName = getStatsFileName(gameName: gameName)
        
        encode(gameStats: gameStats, gameName: gameName,statsFileName: statsFileName, gameLevel: gameLevel)
    }
    
    func getStatistics(gameName: String, gameLevel: DifficultyLevels) -> GameStatistics? {
        let statsFileName = getStatsFileName(gameName: gameName)
        let difficultyLevelString = DifficultyLevelsStringToEnum().getDifficultyLevelStringByEnum(level: gameLevel)
        
        return decode(gameName: gameName, statsFileName: statsFileName, gameLevel: difficultyLevelString)
    }
    
    func deleteGameStatistics(gameName: String) {
        let levels = DifficultyLevelsStringToEnum().getDifficultyLevelsNames()
        
        let statsFileName = getStatsFileName(gameName: gameName)
        
        for level in levels {
            deleteGameInfo(gameName: gameName, level: level, statsFileName: statsFileName)
        }
    }
    
    private func getStatsFileName(gameName: String) -> String {
        var statsFileName = ""
        
        if let statisticssFileName = AllGames().getGameStatsFileNameByName(gameName: gameName) {
            statsFileName = statisticssFileName
        } else {
            print("Error. There is no Game Info for \(gameName)")
        }
        
        return statsFileName
    }
    
    private func encode(gameStats: GameStatistics, gameName: String, statsFileName: String, gameLevel: String) {
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
    
    private func decode(gameName: String, statsFileName: String, gameLevel: String) -> GameStatistics? {
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
    
    private func deleteGameInfo(gameName: String, level: String, statsFileName: String) {
        let fileManager = FileManager.default
        
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
