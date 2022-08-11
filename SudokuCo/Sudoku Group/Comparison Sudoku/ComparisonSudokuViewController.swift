//
//  ComparisonSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.06.2022.
//

import UIKit

class ComparisonSudokuViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [String: CGFloat] = ["Easy": 12, "Medium": 7, "Hard": 3, "Expert": 0]
    
    override func viewDidLoad() {
        super.configureInit()
        
//        super.generalSudokuController.gamesInfoCoding.configureInfoForSaving(gameName: "Comparison Sudoku")
        super.gameName = "Comparison Sudoku"
        super.openedNum = openedNumsLevels[gameMode] ?? openedNumsLevels["Easy"]!
        super.viewDidLoad()
        
        configureMoreLessSigns()
    }
    
    func configureMoreLessSigns() {

        let sudokuNumbers = generalSudokuController.generalSudokuGame.getSudokuNumbers()

        for i in 0...8 {
            for j in 0..<8 {
                if (j + 1) % 3 != 0 {
                    for k in 1...2 {
                        var a = sudokuNumbers[i][j]
                        var b = sudokuNumbers[i][j + 1]

                        var signCenter = CGPoint(x: CGFloat(i) * cellSize + cellSize / 2, y: (CGFloat(j) + 1) * cellSize)

                        let signView = MoreLessSignView()
                        signView.configureSign(cellSize: cellSize)

                        if k == 2 {
                            a = sudokuNumbers[j][i]
                            b = sudokuNumbers[j + 1][i]
                            signCenter = CGPoint(x: (CGFloat(j) + 1) * cellSize, y: CGFloat(i) * cellSize + cellSize / 2)
                            signView.transform = signView.transform.rotated(by: .pi * 1.5)
                        }

                        if a > b {
                            signView.transform = signView.transform.rotated(by: .pi)
                        }

                        signView.center = gridView.convert(signCenter, to: gridView)
                        gridView.addSubview(signView)
                    }
                }
            }
        }
    }
}
