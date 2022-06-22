//
//  ClassicSudokuGame.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 17.06.2022.
//

import UIKit

class ClassicSudokuGame {
    private var sudokuNumbers: [[Int]] = []
    
    private var originallyOpenedNumbers: [[Int]] = []
    private var openedNumbers: [[Int]] = []
    
    private let n = 3
    
    init() {
        for _ in 0...n*n {
            originallyOpenedNumbers.append([Int](repeating: 0, count: n*n))
        }
        
        generateSudoku()
        
        openedNumbers = originallyOpenedNumbers
    }
    
    func fillCell(x: Int, y: Int, value: Int) -> Bool {
        if originallyOpenedNumbers[x][y] == 0 {
            openedNumbers[x][y] = value
            return true
        }
        return false
    }
    
    func deleteCellNumber(x: Int, y: Int) -> Bool {
        if originallyOpenedNumbers[x][y] == 0 {
            openedNumbers[x][y] = 0
            return true
        }
        return false
    }
    
    func getNumberByCoordinates(x: Int, y: Int) -> Int {
        return sudokuNumbers[x][y]
    }
    
    func isNumberOpened(x: Int, y: Int) -> Bool {
        return openedNumbers[x][y] != 0
    }
    
    func getSudokuNumbers() ->  [[Int]] {
        return sudokuNumbers
    }
    
    func getSudokuOriginallyOpenedNumbers() -> [[Int]] {
        return originallyOpenedNumbers
    }
    
    private func generateSudoku() {
        generateBaseGrid()
        
        let transformationFuncs = [transpositionGrid, swapRandomRows, swapRandomColumns, swapRandomRowAreas, swapRandomColumnAreas]
        
        for _ in 0...50 {
            let funcNum = Int.random(in: 0..<transformationFuncs.count)
            transformationFuncs[funcNum]()
        }
        
        generateOpenedNumbers()
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
    
    func generateOpenedNumbers() {
        var index = 0
        
        while index != 30 {
            let pointX = Int.random(in: 0..<n*n)
            let pointY = Int.random(in: 0..<n*n)
            
            if originallyOpenedNumbers[pointX][pointY] == 0 {
                originallyOpenedNumbers[pointX][pointY] = sudokuNumbers[pointX][pointY]
                index += 1
            }
        }
    }
}
