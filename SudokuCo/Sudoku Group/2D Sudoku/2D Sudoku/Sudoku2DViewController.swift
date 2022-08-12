//
//  Sudoku2DViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class Sudoku2DViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [String: CGFloat] = ["Easy": 40, "Medium": 35, "Hard": 30, "Expert": 25]

    override func viewDidLoad() {
        super.configureInit()
        super.gameName = "2D Sudoku"
        super.sudokuType = .sudoku2D
        super.withBoldAreas = false
        super.openedNum = openedNumsLevels[gameMode] ?? openedNumsLevels["Easy"]!

        super.viewDidLoad()
    }
}
