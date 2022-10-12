//
//  MathraxViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class MathraxViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 25, .medium: 18, .hard: 13, .expert: 7]
    
    override func viewDidLoad() {
        super.gameController.gameProcessor = MathraxProcessor()
        
        super.gameSettings.gameName = .mathraxSudoku
        super.gameSettings.sudokuType = .sudoku2D
        super.gameSettings.withBoldAreas = false
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 28
        
        super.viewDidLoad()
        
        fillCircles()
    }
    
    private func fillCircles() {
        let circles = (gameController.gameProcessor as? MathraxProcessor)?.circles
        
        for i in Constants.sudokuHalfRange {
            for j in Constants.sudokuHalfRange {
                let pointCenter = CGPoint(x: (Double(i) + 1) * super.gameSettings.cellSize, y: (Double(j) + 1) * super.gameSettings.cellSize)
                
                if let (circleType, value) = circles?[[i, j]] {
                    let circle = CircleWithSurCellsInfo()
                    
                    let valueString = value != nil ? String(value!) : ""
                    circle.configureCircle(cellSize: super.gameSettings.cellSize, circleType: circleType, value: valueString)
                    
                    let gridView = super.gameController.gridView
                    circle.center = gridView.convert(pointCenter, from: gridView)
                    gridView.addSubview(circle)
                }
            }
        }
    }
}
