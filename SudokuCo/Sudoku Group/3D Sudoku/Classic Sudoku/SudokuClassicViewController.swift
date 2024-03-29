//
//  SudokuClassicViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuClassicViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 41, .medium: 35, .hard: 30, .expert: 27]
    
    override func viewDidLoad() {
        super.gameController.gameProcessor = SudokuClassicProcessor()
        
        super.gameSettings.gameName = .classicSudoku
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 40
        
        super.viewDidLoad()
    }
}
