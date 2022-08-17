//
//  SudokuClassicController1.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 17.08.2022.
//

import Foundation

class SudokuClassicController: GeneralSudokuController {
    
    private var sudokuNumbersRight: [[Int]] = []
    
    private var solution: [[Int]] = []
    
    private var isOneSolution: Bool? = nil
    private var passNumber = 200
    private var removeNumbersCount = 0
    
    func generateNewOpenedNum(openedNum: Int) {
        sudokuNumbersRight = super.getSudokuNumbers()
        solution = sudokuNumbersRight
        removeNumbersCount = 81 - openedNum
        
        while removeNumbersCount != 0 && passNumber > 0 {
            let x = Int.random(in: 0...8)
            let y = Int.random(in: 0...8)
            
            passNumber -= 1
            
            if removeItem(x, y) {
                removeNumbersCount -= 1
            }
        }
        
        super.setOpenedNums(solution)
    }
    
    private func removeItem(_ x: Int,_ y: Int) -> Bool {
        if solution[x][y] == 0 {
            return false
        }
        
        solution[x][y] = 0
        
        _ = solveSudoku(intermidiateNumbers: solution, x: 0, y: 0)
        if isOneSolution == false {
            isOneSolution = nil
            solution[x][y] = sudokuNumbersRight[x][y]
            return false
        }
        return true
    }
    
    private func solveSudoku(intermidiateNumbers: [[Int]], x: Int, y: Int) -> Bool {
        var intermidiateNumbers = intermidiateNumbers
        var i = x
        var j = y
        
        if i > 8 && j >= 8 {
            if isOneSolution == nil {
                isOneSolution = true
                return false
            }
            
            if isOneSolution == true {
                isOneSolution = false
                return true
            }
            return true
        }
        
        if i > 8 {
            i = 0
            j += 1
        }
        
        if intermidiateNumbers[i][j] != 0 {
            return solveSudoku(intermidiateNumbers: intermidiateNumbers, x: i + 1, y: j)
        }
        
        for num in 1...9 {
            if isCellSafeForNum(intermidiateNumbers: intermidiateNumbers, i: i, j: j, num: num) {
                intermidiateNumbers[i][j] = num
                
                if solveSudoku(intermidiateNumbers: intermidiateNumbers, x: i + 1, y: j) {
                    return true
                }
            }
            intermidiateNumbers[i][j] = 0
        }
        return false
    }
    
    private func isCellSafeForNum(intermidiateNumbers: [[Int]], i: Int, j: Int, num: Int) -> Bool {
        return (isUnusedInRow(intermidiateNumbers: intermidiateNumbers, i: i, j: j, num: num) &&
                isUnusedInColumn(intermidiateNumbers: intermidiateNumbers, i: i, j: j, num: num) &&
                isUnusedInArea(intermidiateNumbers: intermidiateNumbers, i: i, j: j, num: num))
    }
    
    private func isUnusedInColumn(intermidiateNumbers: [[Int]], i: Int, j: Int, num: Int) -> Bool {
        return !intermidiateNumbers[i].contains(num)
    }
    
    private func isUnusedInRow(intermidiateNumbers: [[Int]], i: Int, j: Int, num: Int) -> Bool {
        for column in intermidiateNumbers {
            if column[j] == num {
                return false
            }
        }
        return true
    }
    
    private func isUnusedInArea(intermidiateNumbers: [[Int]], i: Int, j: Int, num: Int) -> Bool {
        let startX = 3 * Int(floor(Double(i) / 3.0))
        let startY = 3 * Int(floor(Double(j) / 3.0))
        
        for x in startX...startX + 2 {
            for y in startY...startY + 2{
                if intermidiateNumbers[x][y] == num {
                    return false
                }
            }
        }
        return true
    }
}
