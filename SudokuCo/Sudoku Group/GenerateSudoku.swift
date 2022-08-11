//
//  GenerateSudoku.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 22.06.2022.
//

import Foundation

struct GenerateSudoku {

    private var sudokuNumbers: [[Int]] = []
    private var originallyOpenedNumbers: [[Int]] = []
    
    private var openedNumbersCount: Int = 0
    
    private var sudokuType: SudokuTypes
    
    private let n = 3
    
    init(sudokuType: SudokuTypes = .sudoku3D, openedNum: Int = 30) {
        for _ in 0..<n*n {
            originallyOpenedNumbers.append([Int](repeating: 0, count: n*n))
            sudokuNumbers.append([Int](repeating: 0, count: n*n))
        }
        
        self.openedNumbersCount = openedNum
        self.sudokuType = sudokuType
        
        generateSudoku()
    }
    
    private mutating func generateSudoku() {
        generateBasic()
        
        _ = fillRemainingCells(x: 3, y: 0)
        
        generateOpenedNumbers()
        
        if sudokuType == .sudoku2D {
            shuffleColumnsAndRows()
        }
    }
    
    private mutating func generateBasic() {
        for k in 0...2 {
            var nums = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
            for i in k * 3..<(k + 1) * 3 {
                for j in k * 3..<(k + 1) * 3 {
                    nums.shuffle()
                    sudokuNumbers[i][j] = nums.removeLast()
                }
            }
        }
    }
    
    private mutating func fillRemainingCells(x: Int, y: Int) -> Bool {
        var i = x
        var j = y
        
        for num in 1...9 {
            if isCellSafeForNum(i: i, j: j, num: num) {
                sudokuNumbers[i][j] = num
                
                i += 1
                
                if i >= n*n {
                    i = 0
                    j += 1
                }
                
                if (0...2).contains(i) && (0...2).contains(j){
                    i = n
                }
                
                if (3...5).contains(i) && (3...5).contains(j){
                    i = 2*n
                }
                
                if (6...8).contains(i) && (6...8).contains(j){
                    if j >= n*n - 1 {
                        return true
                    }
                    i = 0
                    j += 1
                }
                
                if fillRemainingCells(x: i, y: j) {
                    return true
                }
                
                i = x
                j = y
                sudokuNumbers[i][j] = 0
            }
        }
        
        return false
    }
    
    private func isCellSafeForNum(i: Int, j: Int, num: Int) -> Bool {
        return (isUnusedInRow(i: i, j: j, num: num) &&
                isUnusedInColumn(i: i, j: j, num: num) &&
                isUnusedInArea(i: i, j: j, num: num))
    }
    
    private func isUnusedInColumn(i: Int, j: Int, num: Int) -> Bool {
        return !sudokuNumbers[i].contains(num)
    }
    
    private func isUnusedInRow(i: Int, j: Int, num: Int) -> Bool {
        for column in sudokuNumbers {
            if column[j] == num {
                return false
            }
        }
        return true
    }
    
    private func isUnusedInArea(i: Int, j: Int, num: Int) -> Bool {
        let startX = 3 * Int(floor(Double(i) / 3.0))
        let startY = 3 * Int(floor(Double(j) / 3.0))
        
        for x in startX...startX + 2 {
            for y in startY...startY + 2{
                if sudokuNumbers[x][y] == num {
                    return false
                }
            }
        }
        return true
    }
    
    private mutating func shuffleColumnsAndRows(forTimes: Int = 50) {
        for _ in 0...forTimes {
            let el1 = Int.random(in: 0..<n*n)
            let el2 = Int.random(in: 0..<n*n)
            
            if Int.random(in: 0...1) == 0 {
                changeTwoRandomRows(row1: el1, row2: el2)
            } else {
                changeTwoRandomColumns(column1: el1, column2: el2)
            }
        }
    }
    
    private mutating func changeTwoRandomRows(row1: Int, row2: Int) {
        for i in 0...8 {
            let elementBuf = sudokuNumbers[i][row1]
            sudokuNumbers[i][row1] = sudokuNumbers[i][row2]
            sudokuNumbers[i][row2] = elementBuf
        }
    }
    
    private mutating func changeTwoRandomColumns(column1: Int, column2: Int) {
        for i in 0...8 {
            let elementBuf = sudokuNumbers[column1][i]
            sudokuNumbers[column1][i] = sudokuNumbers[column2][i]
            sudokuNumbers[column2][i] = elementBuf
        }
    }
    
    private mutating func generateOpenedNumbers() {
        var index = 0
        
        while index != openedNumbersCount {
            let pointX = Int.random(in: 0..<n*n)
            let pointY = Int.random(in: 0..<n*n)
            
            if originallyOpenedNumbers[pointX][pointY] == 0 {
                originallyOpenedNumbers[pointX][pointY] = sudokuNumbers[pointX][pointY]
                index += 1
            }
        }
    }
    
    func getSudokuNumbers() -> [[Int]] {
        return sudokuNumbers
    }
    
    func getOriginallyOpenedNumbers() -> [[Int]] {
        return originallyOpenedNumbers
    }
}
