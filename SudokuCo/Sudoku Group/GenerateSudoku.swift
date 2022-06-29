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
    
    func printNumbers() {
        for i in 0...8 {
            print(sudokuNumbers[i])
        }
    }
    
    init(openedNum: Int = 30) {
        for _ in 0..<n*n {
            originallyOpenedNumbers.append([Int](repeating: 0, count: n*n))
        }
        
        generateSudoku(openedNum: openedNum)
    }
    
    func getSudokuNumbers() -> [[Int]]{
        return sudokuNumbers
    }
    
    func getOriginallyOpenedNumbers() -> [[Int]] {
        return originallyOpenedNumbers
    }
    
    private func generateSudoku(openedNum: Int) {
        generateBaseGrid()
        
        printNumbers()
        
        let transformationFuncs = [transpositionGrid, swapRandomRows, swapRandomColumns, swapRandomRowAreas, swapRandomColumnAreas, changeTwoRandomNumber]
        
        for _ in 0...50 {
            let funcNum = Int.random(in: 0..<transformationFuncs.count)
            print("-----------------------------------")
            print(funcNum)
            transformationFuncs[funcNum]()
            printNumbers()
        }
        
        generateOpenedNumbers(openedNum: openedNum)
    }
    
    private func generateBaseGrid() {
        for i in 0..<n*n {
            sudokuNumbers.append([])
            for j in 0..<n*n {
                sudokuNumbers[i].append(Int(((i * n + i / n + j) % (n*n) + 1)))
            }
        }
    }
    
    private func transpositionGrid() {
        var result: [[Int]] = []
        for index in 0..<n*n {
            result.append(sudokuNumbers.map{$0[index]})
        }
        sudokuNumbers = result
    }
    
    private func swapRandomRows() {
        let rowToSwap1 = Int.random(in: 0..<n*n)
        var delta = [0, 1, 2]
        delta.remove(at: rowToSwap1 % n)
        let rowToSwap2 = (rowToSwap1 / n) * n + delta.randomElement()!
        
        swapTwoRows(rw1: rowToSwap1, rw2: rowToSwap2)
    }
    
    private func swapTwoRows(rw1: Int, rw2: Int) {
        let rowVariable = sudokuNumbers[rw2]
        sudokuNumbers[rw2] = sudokuNumbers[rw1]
        sudokuNumbers[rw1] = rowVariable
    }
    
    private func swapRandomColumns() {
        let columnToSwap1 = Int.random(in: 0..<n*n)
        var delta = [0, 1, 2]
        delta.remove(at: columnToSwap1 % n)
        let columnToSwap2 = (columnToSwap1 / n) * n + delta.randomElement()!
        
        swapTwoColumns(col1: columnToSwap1, col2: columnToSwap2)
    }
    
    private func swapTwoColumns(col1: Int, col2: Int) {
        for index in 0..<n*n {
            let columnVariable = sudokuNumbers[index][col2]
            sudokuNumbers[index][col2] = sudokuNumbers[index][col1]
            sudokuNumbers[index][col1] = columnVariable
        }
    }
    
    private func swapRandomRowAreas() {
        var delta = [0, 1, 2]
        delta.remove(at: Int.random(in: 0..<n))
        
        for i in 0..<n {
            swapTwoRows(rw1: n * delta[0] + i, rw2: n * delta[1] + i)
        }
    }
    
    private func swapRandomColumnAreas() {
        var delta = [0, 1, 2]
        delta.remove(at: Int.random(in: 0..<n))
        
        for i in 0..<n {
            swapTwoColumns(col1: n * delta[0] + i, col2: n * delta[1] + i)
        }
    }
    
    private func generateOpenedNumbers(openedNum: Int) {
        var index = 0
        
        while index != openedNum {
            let pointX = Int.random(in: 0..<n*n)
            let pointY = Int.random(in: 0..<n*n)
            
            if originallyOpenedNumbers[pointX][pointY] == 0 {
                originallyOpenedNumbers[pointX][pointY] = sudokuNumbers[pointX][pointY]
                index += 1
            }
        }
    }
    
    private func changeTwoRandomNumber() {
        var firstNumber = 0
        var secondNumber = 0
        while firstNumber == secondNumber {
            firstNumber = Int.random(in: 1...n*n)
            secondNumber = Int.random(in: 1...n*n)
        }
        
        print(firstNumber, secondNumber)
        
        for i in 0...8 {
            for j in 0...8 {
                if sudokuNumbers[i][j] == firstNumber {
                    sudokuNumbers[i][j] = secondNumber
                } else if sudokuNumbers[i][j] == secondNumber {
                    sudokuNumbers[i][j] = firstNumber
                }
            }
        }
    }
}
