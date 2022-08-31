//
//  ComparisonSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.06.2022.
//

import UIKit

class ComparisonSudokuViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 12, .medium: 7, .hard: 3, .expert: 0]
    
    override func viewDidLoad() {
        super.gameSettings.gameName = "Comparison Sudoku"
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 12
        
        super.viewDidLoad()
        
        configureMoreLessSigns()
    }
    
    func configureMoreLessSigns() {
        let sudokuNumbers = super.gameController.gameProcessor.gameState.sudokuNumbers

        for i in 0...8 {
            for j in 0..<8 {
                if (j + 1) % 3 != 0 {
                    for k in 1...2 {
                        var a = sudokuNumbers[i][j]
                        var b = sudokuNumbers[i][j + 1]

                        var signCenter = CGPoint(x: Double(i) * gameSettings.cellSize + gameSettings.cellSize / 2, y: (Double(j) + 1) * gameSettings.cellSize)

                        let signView = MoreLessSignView()
                        signView.configureSign(cellSize: gameSettings.cellSize)

                        if k == 2 {
                            a = sudokuNumbers[j][i]
                            b = sudokuNumbers[j + 1][i]
                            signCenter = CGPoint(x: (Double(j) + 1) * gameSettings.cellSize, y: Double(i) * gameSettings.cellSize + gameSettings.cellSize / 2)
                            signView.transform = signView.transform.rotated(by: .pi * 1.5)
                        }

                        if a > b {
                            signView.transform = signView.transform.rotated(by: .pi)
                        }

                        let gridView = super.gameController.gridView
                        signView.center = gridView.convert(signCenter, to: gridView)
                        gridView.addSubview(signView)
                    }
                }
            }
        }
    }
}
