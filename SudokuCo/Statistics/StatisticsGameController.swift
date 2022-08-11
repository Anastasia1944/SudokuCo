//
//  StatisticsGameController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 11.08.2022.
//

import Foundation

struct StatiscticsGameController {
    
    private var statisticsCoding = StatisticGameCoding()
    
    func addNewStatisticsElement(gameName: String, gameLevel: DifficultyLevels, time: Int, isWin: Bool) -> GameStatistics? {
        guard var statistics = statisticsCoding.getStatistics(gameName: gameName, gameLevel: gameLevel) else { return nil }
        
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
    
    func getStatistics(gameName: String, gameLevel: DifficultyLevels) -> GameStatistics? {
        guard let statistics = statisticsCoding.getStatistics(gameName: gameName, gameLevel: gameLevel) else { return nil }
        
        return statistics
    }
}
