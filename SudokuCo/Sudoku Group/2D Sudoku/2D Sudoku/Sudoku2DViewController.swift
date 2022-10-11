//
//  Sudoku2DViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class Sudoku2DViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 47, .medium: 41, .hard: 37, .expert: 33]

    override func viewDidLoad() {
        super.gameController.gameProcessor = Sudoku2DProcessor()
        
        super.gameSettings.gameName = .sudoku2D
        super.gameSettings.sudokuType = .sudoku2D
        super.gameSettings.withBoldAreas = false
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 40

        super.viewDidLoad()
    }
}
