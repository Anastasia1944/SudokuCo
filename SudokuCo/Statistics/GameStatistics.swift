//
//  GameStatistics.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 08.07.2022.
//

import Foundation

struct GameStatistics: Codable {
    var gameName: GamesNames = .classicSudoku
    var gameLevel: DifficultyLevels = .easy
    var times: [Int] = []
    var allgamesCount: Int = 0
    var winGamesCount: Int = 0
}
