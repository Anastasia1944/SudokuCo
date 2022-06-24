//
//  ClassicSudokuGame.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 17.06.2022.
//

import UIKit

struct SudokuAction: Codable {
    let xCell: Int
    let yCell: Int
    let lastNumber: Int
}

class ClassicSudokuGame: Codable {
    private var sudokuNumbers: [[Int]] = []
    
    private var originallyOpenedNumbers: [[Int]] = []
    private var openedNumbers: [[Int]] = []
    
    private var sudokuActions: [SudokuAction] = []
    
    func generateSudoku() {
        let generateSudoku = GenerateSudoku()
        sudokuNumbers = generateSudoku.getSudokuNumbers()
        originallyOpenedNumbers = generateSudoku.getOriginallyOpenedNumbers()
        
        openedNumbers = originallyOpenedNumbers
    }
    
    func cancelAction() -> SudokuAction? {
        
        guard let lastAction = sudokuActions.popLast() else { return nil }
        
        openedNumbers[lastAction.xCell][lastAction.yCell] = lastAction.lastNumber
        return lastAction
    }
    
    func fillCell(x: Int, y: Int, value: Int) -> Bool {
        if originallyOpenedNumbers[x][y] == 0 {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y,lastNumber: openedNumbers[x][y]))
            openedNumbers[x][y] = value
            return true
        }
        return false
    }
    
    func fillCellbyRightNumber(x: Int, y: Int) -> Int {
        if openedNumbers[x][y] == 0 {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y,lastNumber: openedNumbers[x][y]))
            openedNumbers[x][y] = sudokuNumbers[x][y]
        }
        return sudokuNumbers[x][y]
    }
    
    func deleteCellNumber(x: Int, y: Int) -> Bool {
        if originallyOpenedNumbers[x][y] == 0 {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: openedNumbers[x][y]))
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
    
    func getSudokuNumbers() -> [[Int]] {
        return sudokuNumbers
    }
    
    func getSudokuOriginallyOpenedNumbers() -> [[Int]] {
        return originallyOpenedNumbers
    }
    
    func getSudokuOpenedNumbers() -> [[Int]] {
        return openedNumbers
    }
}
