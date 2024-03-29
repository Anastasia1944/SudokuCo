//
//  StatisticsGameController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 11.08.2022.
//

import Foundation

struct StatiscticsGameController {
    
    private var statisticsCoding = StatisticGameCoding()
    
    func addNewStatisticsElement(gameName: GamesNames, gameLevel: DifficultyLevels, time: Int, isWin: Bool) -> GameStatistics {
        var statistics = GameStatistics()
        
        if let stats = statisticsCoding.getStatistics(gameName: gameName, gameLevel: gameLevel) {
            statistics = stats
        }
        
        statistics.gameName = gameName
        statistics.gameLevel = gameLevel
        
        statistics.times.append(time)
        statistics.allgamesCount += 1
        if isWin {
            statistics.winGamesCount += 1
        }
        
        statisticsCoding.saveGameStatistics(gameStats: statistics)
        
        return statistics
    }
    
    func getStatistics(gameName: GamesNames, gameLevel: DifficultyLevels) -> GameStatistics? {
        guard let statistics = statisticsCoding.getStatistics(gameName: gameName, gameLevel: gameLevel) else { return nil }
        
        return statistics
    }
}
