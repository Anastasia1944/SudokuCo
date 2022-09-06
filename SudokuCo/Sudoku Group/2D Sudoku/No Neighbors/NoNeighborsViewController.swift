//
//  NoNeighborsViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class NoNeighborsViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 30, .medium: 25, .hard: 20, .expert: 15]
    
    override func viewDidLoad() {
        super.gameSettings.gameName = .noNeighboursSudoku
        super.gameSettings.sudokuType = .sudoku2D
        super.gameSettings.withBoldAreas = false
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 30
        
        super.viewDidLoad()
        
        addBoldLines()
    }
    
    private func addBoldLines() {
        let sudokuNumbers = super.gameController.gameProcessor.gameState.sudokuNumbers
        
        for i in Constants.sudokuRange {
            for j in Constants.sudokuHalfRange {
                for k in 1...2 {
                    var a = sudokuNumbers[i][j]
                    var b = sudokuNumbers[i][j + 1]
                    
                    var pointCenter = CGPoint(x: Double(i) * super.gameSettings.cellSize + super.gameSettings.cellSize / 2, y: (Double(j) + 1) * super.gameSettings.cellSize)
                    
                    let boldLine = BoldLine()
                    boldLine.configureBoldLine(cellSize: super.gameSettings.cellSize)
                    
                    if k == 2 {
                        a = sudokuNumbers[j][i]
                        b = sudokuNumbers[j + 1][i]
                        pointCenter = CGPoint(x: (Double(j) + 1) * super.gameSettings.cellSize, y: Double(i) * super.gameSettings.cellSize + super.gameSettings.cellSize / 2)
                        boldLine.transform = boldLine.transform.rotated(by: .pi * 1.5)
                    }
                    
                    if ifTwoNumbersDiffersInOne(a: a, b: b) {
                        let gridView = super.gameController.gridView
                        boldLine.center = gridView.convert(pointCenter, from: gridView)
                        gridView.addSubview(boldLine)
                    }
                }
            }
        }
    }
    
    func ifTwoNumbersDiffersInOne(a: Int, b: Int) -> Bool {
        if a == b + 1 || a == b - 1 {
            return true
        }
        return false
    }
}
