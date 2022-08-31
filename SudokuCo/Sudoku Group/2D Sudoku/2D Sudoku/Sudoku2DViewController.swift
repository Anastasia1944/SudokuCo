//
//  Sudoku2DViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class Sudoku2DViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 40, .medium: 35, .hard: 30, .expert: 25]

    override func viewDidLoad() {
        super.gameSettings.gameName = "2D Sudoku"
        super.gameSettings.sudokuType = .sudoku2D
        super.gameSettings.withBoldAreas = false
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 40

        super.viewDidLoad()
    }
}
