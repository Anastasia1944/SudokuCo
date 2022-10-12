//
//  OddEvenSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 24.06.2022.
//

import UIKit

class OddEvenSudokuViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 35, .medium: 30, .hard: 27, .expert: 23]
    
    override func viewDidLoad() {
        super.gameController.gameProcessor = OddEvenSudokuProcessor()
        
        super.gameSettings.gameName = .oddEvenSudoku
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 30
        
        super.viewDidLoad()
        
        makeCircles()
    }
    
    func makeCircles() {
        let sudokuNumbers = super.gameController.gameProcessor.gameState.sudokuNumbers
        
        for i in Constants.sudokuRange {
            for j in Constants.sudokuRange {
                if sudokuNumbers[i][j] % 2 != 0 {
                    let circle = UIBezierPath(arcCenter: CGPoint(x: Double(i) * super.gameSettings.cellSize + super.gameSettings.cellSize / 2, y: Double(j) * super.gameSettings.cellSize + super.gameSettings.cellSize / 2), radius: 0.8 * CGFloat((super.gameSettings.cellSize / 2)), startAngle: 0, endAngle: Double.pi * 2, clockwise: true)
                    
                    let shapeLayer = CAShapeLayer()
                    shapeLayer.path = circle.cgPath
                    shapeLayer.strokeColor = UIColor.darkBlue.cgColor
                    shapeLayer.fillColor = UIColor.clear.cgColor
                    shapeLayer.lineWidth = 0.5
                    
                    super.gameController.gridView.layer.addSublayer(shapeLayer)
                }
            }
        }
    }
}
