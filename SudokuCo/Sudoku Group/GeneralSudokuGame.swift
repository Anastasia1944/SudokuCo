//
//  GeneralSudokuGame.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 02.07.2022.
//

import Foundation

class GeneralSudokuGame: Codable {
    private var sudokuNumbers: [[Int]] = []
    
    private var originallyOpenedNumbers: [[Int]] = []
    private var openedNumbers: [[Int]] = []
    
    private var notesNumbers: [[[Int: Bool]]] = []
    
    private var sudokuActions: [SudokuAction] = []
    
    func generateSudoku(openedNum: Int = 0) {
        fillNotesNumbersArray()
        
        let generateSudoku = GenerateSudoku(openedNum: openedNum)
        sudokuNumbers = generateSudoku.getSudokuNumbers()
        originallyOpenedNumbers = generateSudoku.getOriginallyOpenedNumbers()
        
        openedNumbers = originallyOpenedNumbers
    }
    
    func fillNotesNumbersArray() {
        for i in 0...8 {
            notesNumbers.append([])
            for j in 0...8 {
                notesNumbers[i].append([:])
                notesNumbers[i][j] = [1: false, 2: false, 3: false,4: false, 5: false, 6: false, 7: false, 8: false, 9: false]
            }
        }
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
        
        if lastAction.note {
                notesNumbers[lastAction.xCell][lastAction.yCell][lastAction.lastNumber] = !notesNumbers[lastAction.xCell][lastAction.yCell][lastAction.lastNumber]!
        } else {
            openedNumbers[lastAction.xCell][lastAction.yCell] = lastAction.lastNumber
        }
        
        return lastAction
    }
    
    func fillCell(x: Int, y: Int, value: Int) -> Bool {
        if originallyOpenedNumbers[x][y] == 0 {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: openedNumbers[x][y]))
            openedNumbers[x][y] = value
            return true
        }
        return false
    }
    
    func fillCellByNote(x: Int, y: Int, value: Int) -> Bool {
        if originallyOpenedNumbers[x][y] == 0 {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: value, note: true, isAddNote: notesNumbers[x][y][value]!))
            notesNumbers[x][y][value] = !notesNumbers[x][y][value]!
            return true
        }
        return false
    }
    
    func clearCellNotes(x: Int, y: Int) {
        notesNumbers[x][y] = [1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false, 8: false, 9: false]
    }
    
    func fillCellbyRightNumber(x: Int, y: Int) -> Int {
        if originallyOpenedNumbers[x][y] == 0 {
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
    
    func isNumberOriginallyOpened(x: Int, y: Int) -> Bool {
        if originallyOpenedNumbers[x][y] != 0 {
            return true
        }
        return false
    }
    
    func getNumberByCoordinates(x: Int, y: Int) -> Int {
        return sudokuNumbers[x][y]
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
    
    func getSudokuNotesNumbers() -> [[[Int: Bool]]] {
        return notesNumbers
    }
}

