//
//  GeneralSudokuGame.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 02.07.2022.
//

import Foundation

class SudokuState: Codable {
    
    var gameName: GamesNames = .classicSudoku
    var gameLevel: DifficultyLevels = .easy
    
    var sudokuNumbers: [[Int]] = []
    var originallyOpenedNumbers: [[Int]] = []
    var openedNumbers: [[Int]] = []
    var notesNumbers: [[[Int: Bool]]] = []
    
    var tips: Int = 3
    var time: Int = 0
}

