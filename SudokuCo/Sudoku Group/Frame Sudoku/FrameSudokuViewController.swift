//
//  FrameSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 29.06.2022.
//

import UIKit

class FrameSudokuViewController: GeneralSudokuViewController {
    
    var surroundingNumbersLabels: [[UILabel]] = []
    
    override func viewDidLoad() {
        super.configureInit(gridWidth: ((UIScreen.main.bounds.width - 20) / 11) * 9)
        super.generalSudokuController.gamesInfoCoding.configureInfoForSaving(gameName: "Frame Sudoku")
        super.gameName = "Frame Sudoku"
        super.viewDidLoad()
        
        configureSurroundingNumbersOfGrid()
    }
    
    func configureSurroundingNumbersOfGrid() {
        let sudokuNumbers = generalSudokuController.generalSudokuGame.getSudokuNumbers()
        surroundingNumbersLabels = [[], [], [], []]
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: -cellSize, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[i][0] + sudokuNumbers[i][1] + sudokuNumbers[i][2])
            
            surroundingNumbersLabels[0].append(label)
            gridView.addSubview(label)
        }
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: cellSize * 9, y: CGFloat(i) * cellSize, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[6][i] + sudokuNumbers[7][i] + sudokuNumbers[8][i])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: cellSize * 9, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[i][6] + sudokuNumbers[i][7] + sudokuNumbers[i][8])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: -cellSize, y: CGFloat(i) * cellSize, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[0][i] + sudokuNumbers[1][i] + sudokuNumbers[2][i])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
    }
}
