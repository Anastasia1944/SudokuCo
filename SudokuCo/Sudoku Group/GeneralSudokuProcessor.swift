//
//  GameProcessor.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.08.2022.
//

import Foundation

class GeneralSudokuProcessor {
    
    var gameState = SudokuState()
    var sudokuActions: [SudokuAction] = []
    var isNote: Bool = false
    
    func generateSudoku(gameSettings: GameSettings) {
        gameState.gameLevel = gameSettings.gameLevel
        gameState.gameName = gameSettings.gameName
        
        fillOriginallyOpenedNums()
        fillNotesNumbersArray()
        
        let generateSudoku = GenerateSudoku(sudokuType: gameSettings.sudokuType)
        gameState.sudokuNumbers = generateSudoku.getSudokuNumbers()
        
        removeUnusedNumbers(gameSettings: gameSettings)
        configureOpenedNums(openedNums: gameSettings.openedNum)
    }
    
    func removeUnusedNumbers(gameSettings: GameSettings) {
        for i in Constants.sudokuRange {
            for j in Constants.sudokuRange{
                if !gameSettings.whichNumsSaved.contains(gameState.sudokuNumbers[i][j]) {
                    gameState.sudokuNumbers[i][j] = 0
                }
            }
        }
    }
    
    func configureOpenedNums(openedNums: Int) {
        var index = 0

        while index != openedNums {
            let pointX = Int.random(in: Constants.sudokuRange)
            let pointY = Int.random(in: Constants.sudokuRange)

            if gameState.originallyOpenedNumbers[pointX][pointY] == 0 {
                gameState.originallyOpenedNumbers[pointX][pointY] = gameState.sudokuNumbers[pointX][pointY]
                index += 1
            }
        }
        gameState.openedNumbers = gameState.originallyOpenedNumbers
    }
    
    func fillOriginallyOpenedNums() {
        for _ in Constants.sudokuRange {
            gameState.originallyOpenedNumbers.append([Int](repeating: 0, count: 9))
        }
    }
    
    func fillNotesNumbersArray() {
        for i in Constants.sudokuRange {
            gameState.notesNumbers.append([])
            for j in Constants.sudokuRange {
                gameState.notesNumbers[i].append([:])
                gameState.notesNumbers[i][j] = [1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false, 8: false, 9: false]
            }
        }
    }
    
    func checkIfAllCellsFilled() -> Bool {
        for i in Constants.sudokuRange {
            if gameState.openedNumbers[i].contains(0) {
                return false
            }
        }
        return true
    }
    
    func checkIfAllCellsRight() -> Bool {
        if gameState.openedNumbers == gameState.sudokuNumbers {
            return true
        }
        return false
    }
    
    func fillCell(x: Int, y: Int, value: Int) -> Bool {
        if gameState.originallyOpenedNumbers[x][y] == 0 {
            gameState.openedNumbers[x][y] = value
            return true
        }
        return false
    }
    
    func fillCellByNote(x: Int, y: Int, value: Int) -> Bool {
        if gameState.originallyOpenedNumbers[x][y] == 0 {
            gameState.notesNumbers[x][y][value] = !gameState.notesNumbers[x][y][value]!
            return true
        }
        return false
    }
    
    func clearCellNotes(x: Int, y: Int) {
        gameState.notesNumbers[x][y] = [1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false, 8: false, 9: false]
    }
    
    func fillCellbyRightNumber(x: Int, y: Int) -> Int {
        if gameState.originallyOpenedNumbers[x][y] == 0 {
            gameState.openedNumbers[x][y] = gameState.sudokuNumbers[x][y]
        }
        return gameState.sudokuNumbers[x][y]
    }
    
    func deleteCellNumber(x: Int, y: Int) -> Bool {
        if gameState.originallyOpenedNumbers[x][y] == 0 {
            gameState.openedNumbers[x][y] = 0
            return true
        }
        return false
    }
    
    func decreaseTipsNumbers() {
        gameState.tips -= 1
    }
    
    func setNewOpenedNum(_ openedNums: [[Int]]) {
        gameState.originallyOpenedNumbers = openedNums
    }
    
    func isNumberOriginallyOpened(x: Int, y: Int) -> Bool {
        if gameState.originallyOpenedNumbers[x][y] != 0 {
            return true
        }
        return false
    }
    
    func getNumberByCoordinates(x: Int, y: Int) -> Int {
        return gameState.sudokuNumbers[x][y]
    }
    
    func updateTime(plus: Int) {
        gameState.time += plus
    }
    
    func resetTimer() {
        gameState.time = 0
    }
    
    func addAction(_ action: SudokuAction) {
        sudokuActions.append(action)
    }
    
    func isNotesEmpty(x: Int, y: Int) -> Bool {
        if gameState.notesNumbers[x][y] == [1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false, 8: false, 9: false] {
            return true
        }
        return false
    }
}
