//
//  SudokuClassicViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuClassicViewController: GeneralSudokuViewController {
    
    override func viewDidLoad() {
        super.configureInit()
        super.generalSudokuController.gamesInfoCoding.configureInfoForSaving(gameName: "Classic Sudoku")
        super.gameName = "Classic Sudoku"
        super.openedNum = CGFloat(78)
        
        super.viewDidLoad()
    }
}
