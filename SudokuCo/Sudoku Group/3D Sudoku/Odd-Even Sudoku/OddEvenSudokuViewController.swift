//
//  OddEvenSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 24.06.2022.
//

import UIKit

class OddEvenSudokuViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [String: CGFloat] = ["Easy": 30, "Medium": 25, "Hard": 20, "Expert": 15]
    
    override func viewDidLoad() {
        
        super.configureInit()
        super.gameName = "Odd-Even Sudoku"
        super.openedNum = openedNumsLevels[gameMode] ?? openedNumsLevels["Easy"]!
        super.viewDidLoad()

        makeCircles()
    }
    
    func makeCircles() {
        let sudokuNumbers = generalSudokuController.getSudokuNumbers()

        for i in 0...8 {
            for j in 0...8 {

                if sudokuNumbers[i][j] % 2 != 0 {
                    let circle = UIBezierPath(arcCenter: CGPoint(x: CGFloat(i) * cellSize + cellSize / 2, y: CGFloat(j) * cellSize + cellSize / 2), radius: 0.8 * (cellSize / 2), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)

                    let shapeLayer = CAShapeLayer()
                    shapeLayer.path = circle.cgPath
                    shapeLayer.strokeColor = UIColor.darkGray.cgColor
                    shapeLayer.fillColor = UIColor.clear.cgColor
                    shapeLayer.lineWidth = 0.2

                    gridView.layer.addSublayer(shapeLayer)
                }
            }
        }
    }
}
