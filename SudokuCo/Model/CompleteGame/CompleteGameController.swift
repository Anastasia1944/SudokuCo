//
//  CompleteGameController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 09.07.2022.
//

import Foundation

class CompleteGameController {
    
    private var statisticsCoding = StatisticGameCoding()
    
    private var statistics = GameStatistics()
    
    private var currentTime: Int = 0
    
    func configureStats(gameName: String) {
        statisticsCoding.configureInfoForSaving(gameName: gameName)
        
        guard let stats = statisticsCoding.decode() else { return }
        
        statistics = stats
    }
    
    func addNewElementStatistic(time: Int, isWin: Bool, isSaving: Bool) {
        
        currentTime = time
        
        if isSaving {
            statistics.times.append(time)
            statistics.allgamesCount += 1
            if isWin {
                statistics.winGamesCount += 1
            }
            
            statisticsCoding.encode(gameStats: statistics)
        }
    }
    
    func getCurrentTimeString() -> String {
        return intTimeToString(time: currentTime)
    }
    
    func getWinGamesCount() -> Int {
        return statistics.winGamesCount
    }
    
    func getAllGamesCount() -> Int {
        return statistics.allgamesCount
    }
 
    func getAverageTimeString() -> String {
        
        var time = 0
        
        for i in 0..<statistics.times.count {
            time += statistics.times[i]
        }
        
        return intTimeToString(time: time / statistics.allgamesCount)
    }
    
    func getWinRatePercentage() -> String {
        
        let doubleVar = Double(statistics.winGamesCount) / Double(statistics.allgamesCount) * 100
        
        return String(round(doubleVar * 10) / 10) + "%"
    }
    
    private func intTimeToString(time: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: TimeInterval(time))!
    }
}
