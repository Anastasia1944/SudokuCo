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
    
    var noteChanged: ( (Bool) -> Void )?
    
    private var openedNum = CGFloat(0)
    private var isSaving: Bool = true
    private var isNote: Bool = false {
        didSet {
            self.noteChanged?(isNote)
        }
    }
    
    private var sudokuActions: [SudokuAction] = []
    
    private var timer: Timer?
    private var runCount = 0
    
    init() {
        for _ in 0...8 {
            filledNumbers.append([Int](repeating: 0, count: 9))
        }
    }
    
    func configureController(gameMode: String, openedNum: CGFloat, isSaving: Bool = true) {
        runTimer()
        
        self.openedNum = openedNum
        self.isSaving = isSaving
        
        if gameMode == "Continue" {
            continueGame()
        } else {
            newGame()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        runCount += 1
    }
    
    func stopTimer() -> Int {
        timer?.invalidate()
        
        let newTime = generalSudokuGame.updateTime(plus: runCount)
        runCount = 0
        
        saveInfoIfNedded()
        return newTime
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
        
        var isUndoPrevious: Bool = false
        
        if isNote {
            if filledNumbers[x][y] != 0 {
                sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: filledNumbers[x][y]))
                deleteMainNumber(x: x, y: y)
                
                isUndoPrevious = true
            }
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: value, note: true, isUndoPreviousAction: isUndoPrevious))
            addNoteNumber(x: x, y: y, value: value)
        } else {
            if !isNotesEmpty(x: x, y: y) {
                sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: 0, note: true, isAddNote: false, noteStack: notesNumbers[x][y]))
                deleteNotesNumbers(x: x, y: y)
                
                isUndoPrevious = true
            }
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: filledNumbers[x][y], isUndoPreviousAction: isUndoPrevious))
            addMainNumber(x: x, y: y, value: value)
        }
        saveInfoIfNedded()
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
        saveInfoIfNedded()
    }
    
    func tipButtonTapped(x: Int, y: Int) {
        if !isNotesEmpty(x: x, y: y) {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: 0, note: true, isAddNote: false, noteStack: notesNumbers[x][y]))
            deleteNotesNumbers(x: x, y: y)
        } else {
            sudokuActions.append(SudokuAction(xCell: x, yCell: y, lastNumber: filledNumbers[x][y]))
        }
        
        filledNumbers[x][y] = generalSudokuGame.fillCellbyRightNumber(x: x, y: y)
        saveInfoIfNedded()
    }
    
    func noteButtonTapped() {
        isNote = !isNote
    }
    
    func cancelButtonTapped() {
        if let lastAction = sudokuActions.popLast() {
            if lastAction.note {
                if lastAction.isAddNote {
                    notesNumbers[lastAction.xCell][lastAction.yCell][lastAction.lastNumber] = !notesNumbers[lastAction.xCell][lastAction.yCell][lastAction.lastNumber]!
                } else {
                    notesNumbers[lastAction.xCell][lastAction.yCell] = lastAction.noteStack!
                }
            } else {
                filledNumbers[lastAction.xCell][lastAction.yCell] = lastAction.lastNumber
            }
            
            saveInfoIfNedded()
            
            if lastAction.isUndoPreviousAction {
                cancelButtonTapped()
            }
        }
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
            
            notesNumbers[x][y][value] = !notesNumbers[x][y][value]!
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
        
        runTimer()
        generalSudokuGame.resetTimer()
        
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
