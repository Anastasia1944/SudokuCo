//
//  TestController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 04.07.2022.
//

import UIKit

class GeneralSudokuController {
    
    var generalSudokuGame = GeneralSudokuGame()
    var gamesInfoCoding = GamesInfoCoding()
    
    var numberChanged: ( ([[Int]]) -> Void )?
    
    private var filledNumbers: [[Int]] = [] {
        didSet {
            self.numberChanged?(filledNumbers)
        }
    }
    
    var noteNumberChanged: ( ([[[Int: Bool]]]) -> Void )?
    
    private var notesNumbers: [[[Int: Bool]]] = [] {
        didSet {
            self.noteNumberChanged?(notesNumbers)
        }
    }
    
    private var openedNum = CGFloat(0)
    private var isSaving: Bool = true
    private var isNote: Bool = false
    
    private var sudokuActions: [SudokuAction] = []
    
    init() {
        for _ in 0...8 {
            filledNumbers.append([Int](repeating: 0, count: 9))
        }
    }
    
    func configureController(gameMode: String, openedNum: CGFloat, isSaving: Bool = true) {
        
        self.openedNum = openedNum
        self.isSaving = isSaving
        
        if gameMode == "Continue" {
            continueGame()
        } else {
            newGame()
        }
    }
    
    func newGame() {
        generalSudokuGame.generateSudoku(openedNum: Int(openedNum))
        
        filledNumbers = generalSudokuGame.getSudokuOriginallyOpenedNumbers()
        notesNumbers = generalSudokuGame.getSudokuNotesNumbers()
        
        saveInfoIfNedded()
    }
    
    func continueGame() {
        generalSudokuGame = gamesInfoCoding.decode() as! GeneralSudokuGame
        
        filledNumbers = generalSudokuGame.getSudokuOpenedNumbers()
        notesNumbers = generalSudokuGame.getSudokuNotesNumbers()
    }
    
    func saveInfoIfNedded() {
        if isSaving {
            gamesInfoCoding.encode(game: generalSudokuGame)
        }
    }
    
    func numberButtonTapped(x: Int, y: Int, value: Int) {
        if isNote {
            if filledNumbers[x][y] != 0 {
                sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: filledNumbers[x][y]))
                deleteMainNumber(x: x, y: y)
            }
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: value, note: true))
            addNoteNumber(x: x, y: y, value: value)
        } else {
            if !isNotesEmpty(x: x, y: y) {
                sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: 0, note: true, isAddNote: false, noteStack: notesNumbers[x][y]))
                deleteNotesNumbers(x: x, y: y)
            }
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: filledNumbers[x][y]))
            addMainNumber(x: x, y: y, value: value)
        }
    }
    
    func deleteButtonTapped(x: Int, y: Int) {
        if filledNumbers[x][y] != 0 {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: filledNumbers[x][y]))
            deleteMainNumber(x: x, y: y)
        }
        
        if !isNotesEmpty(x: x, y: y) {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: 0, note: true, isAddNote: false, noteStack: notesNumbers[x][y]))
            deleteNotesNumbers(x: x, y: y)
        }
    }
    
    func tipButtonTapped(x: Int, y: Int) {
        if !isNotesEmpty(x: x, y: y) {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: 0, note: true, isAddNote: false, noteStack: notesNumbers[x][y]))
            deleteNotesNumbers(x: x, y: y)
        } else {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: filledNumbers[x][y]))
        }
        
        filledNumbers[x][y] = generalSudokuGame.fillCellbyRightNumber(x: x, y: y)
    }
    
    func noteButtonTapped() {
        isNote = !isNote
    }
    
    func cancelButtonTapped() -> Bool? {
        guard let lastAction = sudokuActions.popLast() else { return nil }
        
        if lastAction.note {
            if lastAction.isAddNote {
                notesNumbers[lastAction.xCell][lastAction.yCell][lastAction.lastNumber] = false
            } else {
                notesNumbers[lastAction.xCell][lastAction.yCell] = lastAction.noteStack!
            }
        } else {
            filledNumbers[lastAction.xCell][lastAction.yCell] = lastAction.lastNumber
        }
        
        return true
    }
    
    func addMainNumber(x: Int, y: Int, value: Int) {
        if generalSudokuGame.fillCell(x: x, y: y, value: value) {
            saveInfoIfNedded()
            
            filledNumbers[x][y] = value
        }
    }
    
    func addNoteNumber(x: Int, y: Int, value: Int) {
        if generalSudokuGame.fillCellByNote(x: x, y: y, value: value) {
            saveInfoIfNedded()
            
            notesNumbers[x][y][value] = true
        }
    }
    
    func deleteMainNumber(x: Int, y: Int) {
        if generalSudokuGame.deleteCellNumber(x: x, y: y) {
            saveInfoIfNedded()
            
            filledNumbers[x][y] = 0
        }
    }
    
    func deleteNotesNumbers(x: Int, y: Int) {
        generalSudokuGame.clearCellNotes(x: x, y: y)
        saveInfoIfNedded()
        notesNumbers[x][y] = [1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false, 8: false, 9: false]
    }
    
    func isNotesEmpty(x: Int, y: Int) -> Bool {
        if notesNumbers[x][y] == [1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false, 8: false, 9: false] {
            return true
        }
        return false
    }
    
    func ifAllCellsFilledDisplayCompletionView() -> Bool? {
        if generalSudokuGame.checkIfAllCellsFilled() {
            if generalSudokuGame.checkIfAllCellsRight() {
                return true
            } else {
                return false
            }
        }
        return nil
    }
    
    func startGameOver() {
        let originallyOpenedNumbers = generalSudokuGame.getSudokuOriginallyOpenedNumbers()
        
        for i in 0...8 {
            for j in 0...8 {
                if originallyOpenedNumbers[i][j] == 0 {
                    _ = generalSudokuGame.fillCell(x: i, y: j, value: 0)
                    filledNumbers[i][j] = 0
                }
            }
        }
        
        saveInfoIfNedded()
    }
}