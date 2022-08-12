//
//  MathraxViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class MathraxViewController: GeneralSudokuViewController {

    private let openedNumsLevels: [String: CGFloat] = ["Easy": 30, "Medium": 25, "Hard": 20, "Expert": 15]
    
    override func viewDidLoad() {
        super.configureInit()
        super.gameName = "Mathrax"
        super.sudokuType = .sudoku2D
        super.withBoldAreas = false
        super.openedNum = openedNumsLevels[gameMode] ?? openedNumsLevels["Easy"]!

        super.viewDidLoad()
        
        fillCircles()
    }
    
    private func fillCircles() {
        let sudokuNumbers = generalSudokuController.getSudokuNumbers()
        
        for i in 0..<8 {
            for j in 0..<8 {
                let a1 = sudokuNumbers[i][j]
                let b1 = sudokuNumbers[i + 1][j + 1]
                
                let a2 = sudokuNumbers[i+1][j]
                let b2 = sudokuNumbers[i][j + 1]
                
                let pointCenter = CGPoint(x: (CGFloat(i) + 1) * cellSize, y: (CGFloat(j) + 1) * cellSize)
                
                if let (circleType, value) = defineCircleType(a1: a1, b1: b1, a2: a2, b2: b2) {
                    if Int.random(in: 1...2) == 1 {
                        let circle = CircleWithSurCellsInfo()
                        circle.configureCircle(cellSize: cellSize, circleType: circleType, value: value)
                        
                        circle.center = gridView.convert(pointCenter, from: gridView)
                        gridView.addSubview(circle)
                    }
                }
            }
        }
    }
    
    private func defineCircleType(a1: Int, b1: Int, a2: Int, b2: Int) -> (CircleType, String)? {
        if getDifference(a: a1, b: b1) == getDifference(a: a2, b: b2) {
            let differenceString = String(getDifference(a: a1, b: b1))
            return (.difference, differenceString)
        }
        
        if getSum(a: a1, b: b1) == getSum(a: a2, b: b2) {
            let sumString = String(getSum(a: a1, b: b1))
            return (.sum, sumString)
        }
        
        
        if getProduct(a: Double(a1), b: Double(b1)) == getProduct(a: Double(a2), b: Double(b2)) {
            let divString = String(Int(getProduct(a: Double(a1), b: Double(b1))))
            return (.division, divString)
        }
        
        if getQuotient(a: a1, b: b1) == getQuotient(a: a2, b: b2) {
            let multString = String(getQuotient(a: a1, b: b1))
            return (.multiply, multString)
        }
        
        if ifEvenNumbers(a: a1) && ifEvenNumbers(a: b1) && ifEvenNumbers(a: a2) && ifEvenNumbers(a: b2) {
            return (.even, "")
        }
        
        if !ifEvenNumbers(a: a1) && !ifEvenNumbers(a: b1) && !ifEvenNumbers(a: a2) && !ifEvenNumbers(a: b2) {
            return (.odd, "")
        }
        
        return nil
    }
    
    private func getDifference(a: Int, b: Int) -> Int {
        return abs(a - b)
    }
    
    private func getSum(a: Int, b: Int) -> Int {
        return a + b
    }
    
    private func getProduct(a: Double, b: Double) -> Double {
        return a > b ? a / b : b / a
    }
    
    private func getQuotient(a: Int, b: Int) -> Int {
        return a * b
    }
    
    private func ifEvenNumbers(a: Int) -> Bool {
        return a % 2 == 0 ? true : false
    }
}
