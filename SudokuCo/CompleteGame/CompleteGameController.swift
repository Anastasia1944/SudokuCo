//
//  CompleteGameController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 09.07.2022.
//

import Foundation

class CompleteGameController {
    
    private var statisticsGameController = StatiscticsGameController()
    private var statistics = GameStatistics()
    
    private var currentTime: Int = 0
    
    func addNewElementStatistic(gameName: GamesNames, gameLevel: DifficultyLevels, time: Int, isWin: Bool, isSaving: Bool) {
        currentTime = time
        
        if isSaving {
            statistics = statisticsGameController.addNewStatisticsElement(gameName: gameName, gameLevel: gameLevel, time: time, isWin: isWin)
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
    
    func getGameStats(isSaving: Bool, gameLevel: String) -> [(String, String)] {
        if isSaving {
            return [("Level", NSLocalizedString(gameLevel, comment: "")),
                    ("Games Played", String(getAllGamesCount())),
                    ("Current Time", getCurrentTimeString()),
                    ("Average Time", getAverageTimeString())]
        }
        return [("Level", NSLocalizedString(gameLevel, comment: "")),
                ("Current Time", getCurrentTimeString())]
    }
    
    private func intTimeToString(time: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: TimeInterval(time))!
    }
}
