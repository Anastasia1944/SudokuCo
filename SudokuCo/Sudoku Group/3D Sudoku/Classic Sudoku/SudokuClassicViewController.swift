//
//  SudokuClassicViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuClassicViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [String: CGFloat] = ["Easy": 40, "Medium": 35, "Hard": 27, "Expert": 21]
    
    override func viewDidLoad() {
        super.configureInit()
        super.gameName = "Classic Sudoku"
        super.openedNum = openedNumsLevels[gameMode] ?? openedNumsLevels["Easy"]!

        super.viewDidLoad()
    }
}
