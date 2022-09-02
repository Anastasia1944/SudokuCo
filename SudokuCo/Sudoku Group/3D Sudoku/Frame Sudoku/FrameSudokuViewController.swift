//
//  FrameSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 29.06.2022.
//

import UIKit

class FrameSudokuViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 12, .medium: 7, .hard: 3, .expert: 0]
    
    var surroundingNumbersLabels: [[UILabel]] = []
    
    override func viewDidLoad() {
        super.gameSettings.gameName = "Frame Sudoku"
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 12
        super.gameSettings.gridWidth = Double(((UIScreen.main.bounds.width - 20) / 11) * 9)
        super.gameSettings.cellSize = super.gameSettings.gridWidth / 9
        
        super.viewDidLoad()
        
        configureSurroundingNumbersOfGrid()
    }
    
    func configureSurroundingNumbersOfGrid() {
        let sudokuNumbers = super.gameController.gameProcessor.gameState.sudokuNumbers
        surroundingNumbersLabels = [[], [], [], []]
        let gridView = super.gameController.gridView
        
        for i in Constants.sudokuRange {
            let label = UILabel(frame: CGRect(x: Double(i) * super.gameSettings.cellSize, y: -super.gameSettings.cellSize, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[i][0] + sudokuNumbers[i][1] + sudokuNumbers[i][2])
            
            surroundingNumbersLabels[0].append(label)
            gridView.addSubview(label)
        }
        
        for i in Constants.sudokuRange {
            let label = UILabel(frame: CGRect(x: super.gameSettings.cellSize * 9, y: Double(i) * super.gameSettings.cellSize, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[6][i] + sudokuNumbers[7][i] + sudokuNumbers[8][i])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
        
        for i in Constants.sudokuRange {
            let label = UILabel(frame: CGRect(x: Double(i) * super.gameSettings.cellSize, y: super.gameSettings.cellSize * 9, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[i][6] + sudokuNumbers[i][7] + sudokuNumbers[i][8])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
        
        for i in Constants.sudokuRange {
            let label = UILabel(frame: CGRect(x: -super.gameSettings.cellSize, y: Double(i) * super.gameSettings.cellSize, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[0][i] + sudokuNumbers[1][i] + sudokuNumbers[2][i])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
    }
}
