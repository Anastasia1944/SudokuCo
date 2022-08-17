//
//  SudokuClassicViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuClassicViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [String: CGFloat] = ["Easy": 35, "Medium": 30, "Hard": 25, "Expert": 21]
    
    override func viewDidLoad() {
        super.configureInit()
        super.gameName = "Classic Sudoku"
        super.openedNum = openedNumsLevels[gameMode] ?? openedNumsLevels["Easy"]!
        
        let sudokuClassicController = SudokuClassicController()
        super.generalSudokuController = sudokuClassicController

        super.viewDidLoad()
        
        if super.gameMode != "Continue" {
            sudokuClassicController.generateNewOpenedNum(openedNum: Int(super.openedNum))
            super.fillOriginallyOpenedNumbers()
        }
    }
}
