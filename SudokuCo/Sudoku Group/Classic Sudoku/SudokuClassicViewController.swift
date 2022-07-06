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
        super.testController.gamesInfoCoding.configureInfoForSaving(gameName: "Classic Sudoku")
        super.openedNum = CGFloat(30)
        
        super.viewDidLoad()
    }
}
