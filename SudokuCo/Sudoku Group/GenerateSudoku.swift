//
//  GenerateSudoku.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 22.06.2022.
//

import Foundation

class GenerateSudoku {
    
    private var sudokuNumbers: [[Int]] = []
    private var originallyOpenedNumbers: [[Int]] = []
    
    private let n = 3
    
    private var openedNumbersCount: Int = 0
    
    init(openedNum: Int = 30) {
        for _ in 0..<n*n {
            originallyOpenedNumbers.append([Int](repeating: 0, count: n*n))
            sudokuNumbers.append([Int](repeating: 0, count: n*n))
        }
        
        self.openedNumbersCount = openedNum
        
        generateSudoku()
    }
    
    private func generateSudoku() {
        generateBasic()
        
        _ = fillRemainingCells(x: 3, y: 0)
        
        generateOpenedNumbers()
    }
    
    private func generateBasic() {
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
    
    private func fillRemainingCells(x: Int, y: Int) -> Bool {
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
        return (isUnusedInRow(i: i, j: j, num: num) && isUnusedInColumn(i: i, j: j, num: num) && isUnusedInArea(i: i, j: j, num: num))
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
    
    func getSudokuNumbers() -> [[Int]]{
        return sudokuNumbers
    }
    
    func getOriginallyOpenedNumbers() -> [[Int]] {
        return originallyOpenedNumbers
    }
    
    private func generateOpenedNumbers() {
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
}
