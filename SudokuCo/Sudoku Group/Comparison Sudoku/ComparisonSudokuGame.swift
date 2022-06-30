//
//  ComparisonSudokuGame.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.06.2022.
//

import Foundation

class ComparisonSudokuGame: Codable {
    private var sudokuNumbers: [[Int]] = []
    
    private var openedNumbers: [[Int]] = []
    
    private var sudokuActions: [SudokuAction] = []
    
    func generateSudoku() {
        let generateSudoku = GenerateSudoku(openedNum: 0)
        sudokuNumbers = generateSudoku.getSudokuNumbers()
        openedNumbers = generateSudoku.getOriginallyOpenedNumbers()
    }
    
    func checkIfAllCellsFilled() -> Bool {
        for i in 0...8 {
            if openedNumbers[i].contains(0) {
                return false
            }
        }
        return true
    }
    
    func checkIfAllCellsRight() -> Bool {
        if openedNumbers == sudokuNumbers {
            return true
        }
        return false
    }
    
    func cancelAction() -> SudokuAction? {
        guard let lastAction = sudokuActions.popLast() else { return nil }
        
        openedNumbers[lastAction.xCell][lastAction.yCell] = lastAction.lastNumber
        return lastAction
    }
    
    func fillCell(x: Int, y: Int, value: Int) {
        sudokuActions.append(SudokuAction(xCell: x, yCell: y,lastNumber: openedNumbers[x][y]))
        openedNumbers[x][y] = value
    }
    
    func fillCellbyRightNumber(x: Int, y: Int) -> Int {
        sudokuActions.append(SudokuAction(xCell: x, yCell: y,lastNumber: openedNumbers[x][y]))
        openedNumbers[x][y] = sudokuNumbers[x][y]
        return openedNumbers[x][y]
    }
    
    func deleteCellNumber(x: Int, y: Int) {
        sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: openedNumbers[x][y]))
        openedNumbers[x][y] = 0
    }
    
    func getNumberByCoordinates(x: Int, y: Int) -> Int {
        return sudokuNumbers[x][y]
    }
    
    func getSudokuNumbers() -> [[Int]] {
        return sudokuNumbers
    }
    
    func getSudokuOpenedNumbers() -> [[Int]] {
        return openedNumbers
    }
}
