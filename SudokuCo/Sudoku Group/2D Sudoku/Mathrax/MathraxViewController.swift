//
//  MathraxViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class MathraxViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 28, .medium: 23, .hard: 15, .expert: 10]
    
    override func viewDidLoad() {
        super.gameSettings.gameName = .mathraxSudoku
        super.gameSettings.sudokuType = .sudoku2D
        super.gameSettings.withBoldAreas = false
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 28
        
        super.viewDidLoad()
        
        fillCircles()
    }
    
    private func fillCircles() {
        let sudokuNumbers = super.gameController.gameProcessor.gameState.sudokuNumbers
        
        for i in Constants.sudokuHalfRange {
            for j in Constants.sudokuHalfRange {
                let a1 = sudokuNumbers[i][j]
                let b1 = sudokuNumbers[i + 1][j + 1]
                
                let a2 = sudokuNumbers[i+1][j]
                let b2 = sudokuNumbers[i][j + 1]
                
                let pointCenter = CGPoint(x: (Double(i) + 1) * super.gameSettings.cellSize, y: (Double(j) + 1) * super.gameSettings.cellSize)
                
                if let (circleType, value) = defineCircleType(a1: a1, b1: b1, a2: a2, b2: b2) {
                    let circle = CircleWithSurCellsInfo()
                    circle.configureCircle(cellSize: super.gameSettings.cellSize, circleType: circleType, value: value)
                    
                    let gridView = super.gameController.gridView
                    circle.center = gridView.convert(pointCenter, from: gridView)
                    gridView.addSubview(circle)
                }
            }
        }
    }
    
    private func defineCircleType(a1: Int, b1: Int, a2: Int, b2: Int) -> (CircleType, String)? {
        var variants: [(CircleType, String)] = []
        
        if getDifference(a: a1, b: b1) == getDifference(a: a2, b: b2) {
            let differenceString = String(getDifference(a: a1, b: b1))
            variants.append((.difference, differenceString))
        }
        
        if getSum(a: a1, b: b1) == getSum(a: a2, b: b2) {
            let sumString = String(getSum(a: a1, b: b1))
            variants.append((.sum, sumString))
        }
        
        if getProduct(a: Double(a1), b: Double(b1)) == getProduct(a: Double(a2), b: Double(b2)) && (a1.isMultiple(of: b1) || b1.isMultiple(of: a1)) {
            let divString = String(Int(getProduct(a: Double(a1), b: Double(b1))))
            variants.append((.division, divString))
        }
        
        if getQuotient(a: a1, b: b1) == getQuotient(a: a2, b: b2) {
            let multString = String(getQuotient(a: a1, b: b1))
            variants.append((.multiply, multString))
        }
        
        if ifEvenNumbers(a: a1) && ifEvenNumbers(a: b1) && ifEvenNumbers(a: a2) && ifEvenNumbers(a: b2) {
            variants.append((.even, ""))
        }
        
        if !ifEvenNumbers(a: a1) && !ifEvenNumbers(a: b1) && !ifEvenNumbers(a: a2) && !ifEvenNumbers(a: b2) {
            variants.append((.odd, ""))
        }
        
        return variants.isEmpty ? nil : variants.randomElement()//nil
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
