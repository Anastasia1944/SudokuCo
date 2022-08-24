//
//  SudokuClassicViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuClassicViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: CGFloat] = [.easy: 40, .medium: 35, .hard: 27, .expert: 21]
    
    override func viewDidLoad() {
        super.configureInit()
        super.gameName = "Classic Sudoku"
        super.openedNum = openedNumsLevels[gameLevel] ?? openedNumsLevels[.easy] ?? 40

        super.viewDidLoad()
    }
}
