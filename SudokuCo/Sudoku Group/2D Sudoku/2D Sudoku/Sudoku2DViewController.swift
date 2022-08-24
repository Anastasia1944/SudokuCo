//
//  Sudoku2DViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class Sudoku2DViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: CGFloat] = [.easy: 40, .medium: 35, .hard: 30, .expert: 25]

    override func viewDidLoad() {
        super.configureInit()
        super.gameName = "2D Sudoku"
        super.sudokuType = .sudoku2D
        super.withBoldAreas = false
        super.openedNum = openedNumsLevels[gameLevel] ?? openedNumsLevels[.easy] ?? 40

        super.viewDidLoad()
    }
}
