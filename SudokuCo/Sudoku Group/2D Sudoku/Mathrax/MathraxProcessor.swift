//
//  MathraxController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.10.2022.
//

import Foundation

class MathraxProcessor: GeneralSudokuProcessor {
    
    var circles: [[Int]: (CircleType, Int?)] = [:]
    
    override func configureOpenedNums(openedNums: Int) {
        configureCircles()
        
        var index = 0

        while index != openedNums {
            let pointX = Int.random(in: Constants.sudokuRange)
            let pointY = Int.random(in: Constants.sudokuRange)

            if gameState.originallyOpenedNumbers[pointX][pointY] == 0 && gameState.sudokuNumbers[pointX][pointY] != 0 {
                gameState.originallyOpenedNumbers[pointX][pointY] = gameState.sudokuNumbers[pointX][pointY]
                index += 1
            }
        }
        gameState.openedNumbers = gameState.originallyOpenedNumbers
    }
    
    private func configureCircles() {
        let sudokuNumbers = gameState.sudokuNumbers
        for i in Constants.sudokuHalfRange {
            for j in Constants.sudokuHalfRange {
                let a1 = sudokuNumbers[i][j]
                let b1 = sudokuNumbers[i + 1][j + 1]
                
                let a2 = sudokuNumbers[i + 1][j]
                let b2 = sudokuNumbers[i][j + 1]
                
                if let (circleType, value) = defineCircleType(a1: a1, b1: b1, a2: a2, b2: b2) {
                    circles[[i, j]] = (circleType, value)
                }
            }
        }
    }
    
    private func defineCircleType(a1: Int, b1: Int, a2: Int, b2: Int) -> (CircleType, Int?)? {
        var variants: [(CircleType, Int?)] = []
        
        if getDifference(a: a1, b: b1) == getDifference(a: a2, b: b2) {
            let differenceString = getDifference(a: a1, b: b1)
            variants.append((.difference, differenceString))
        }
        
        if getSum(a: a1, b: b1) == getSum(a: a2, b: b2) {
            let sumString = getSum(a: a1, b: b1)
            variants.append((.sum, sumString))
        }
        
        if getProduct(a: Double(a1), b: Double(b1)) == getProduct(a: Double(a2), b: Double(b2)) && (a1.isMultiple(of: b1) || b1.isMultiple(of: a1)) {
            let divString = Int(getProduct(a: Double(a1), b: Double(b1)))
            variants.append((.division, divString))
        }
        
        if getQuotient(a: a1, b: b1) == getQuotient(a: a2, b: b2) {
            let multString = getQuotient(a: a1, b: b1)
            variants.append((.multiply, multString))
        }
        
        if ifEvenNumbers(a: a1) && ifEvenNumbers(a: b1) && ifEvenNumbers(a: a2) && ifEvenNumbers(a: b2) {
            variants.append((.even, nil))
        }
        
        if !ifEvenNumbers(a: a1) && !ifEvenNumbers(a: b1) && !ifEvenNumbers(a: a2) && !ifEvenNumbers(a: b2) {
            variants.append((.odd, nil))
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

