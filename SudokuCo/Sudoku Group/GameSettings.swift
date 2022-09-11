//
//  GameSettings.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.08.2022.
//

import UIKit

class GameSettings {
    var isNewGame: Bool = true
    var gameName: GamesNames = .classicSudoku
    var gameLevel: DifficultyLevels = .easy
    var isSaving: Bool = true
    var openedNum: Int = 0
    var gameTime: Int = 0
    var sudokuType: SudokuTypes = .sudoku3D
    var withOuterBoldBorder: Bool = true
    var withBoldAreas: Bool = true
    var gapNotesShift: Double = 0
    var isOpenLibraryAlert: Bool = true
    var whichNumsSaved: ClosedRange<Int> = Constants.sudokuNumbersRange
    var fillElements: FillElementsTypes = .ints
 
    var gridWidth: Double = Double(UIScreen.main.bounds.width - 20)
    var cellSize: Double = Double(UIScreen.main.bounds.width - 20) / 9
}
