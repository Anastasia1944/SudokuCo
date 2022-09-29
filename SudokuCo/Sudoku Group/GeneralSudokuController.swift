//
//  TestController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 04.07.2022.
//

import UIKit

class GeneralSudokuController {
    
    var gameProcessor = GeneralSudokuProcessor()
    var gameSettings = GameSettings()
    var gamesInfoCoding = GamesInfoCoding()
    
    var gridView = GridView()
    
    let timeModeStackView = UIStackView()
    let gameElementsStackView = UIStackView()
    let sudokuPanelStackView = UIStackView()
    var numberPanelStackView = UIStackView()
    
    let selectedCellView = UIView()
    
    var filledNumbersLabels: [[UILabel]] = []
    var notesLabels: [[[UILabel]]] = []
    
    private var timer: Timer?
    private var runCount = 0
    
    var isTransitionToCompleteVC: ((UIViewController) -> Void)?
    
    // MARK: - Start Game
    func startGame() {
        runTimer()
        
        if gameSettings.isNewGame {
            newGame()
        } else {
            continueGame()
        }
        
        displayAllNumbers()
        addTipsCount()
        addGameMode()
    }
    
    func newGame() {
        _ = autoLosingPreviousGame()
        
        gameProcessor.generateSudoku(gameSettings: gameSettings)
        
        saveInfoIfNedded()
    }
    
    func autoLosingPreviousGame() -> Bool {
        guard let previousGameState = gamesInfoCoding.getGameInfo(gameName: gameSettings.gameName) as? SudokuState else { return false }
        
        let completeGameController = CompleteGameController()
        completeGameController.addNewElementStatistic(gameName: previousGameState.gameName, gameLevel: previousGameState.gameLevel,
                                                      time: previousGameState.time, isWin: false, isSaving: true)
        return true
    }
    
    func continueGame() {
        gameProcessor.gameState = gamesInfoCoding.getGameInfo(gameName: gameSettings.gameName) as! SudokuState
        displayAllNumbers()
    }
    
    // MARK: - Timer
    func runTimer() {
        let timer = Timer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc func fireTimer() {
        runCount += 1
        
        if UserDefaults.standard.bool(forKey: Settings.showTime.rawValue) {
            let currentTimeLabel = timeModeStackView.arrangedSubviews[1] as? UILabel
            currentTimeLabel?.text = timeIntToString(gameProcessor.gameState.time + runCount)
        }
    }
    
    private func timeIntToString(_ timeInt: Int) -> String {
        let formatter = DateComponentsFormatter()
        return formatter.string(from: Double(timeInt))!
    }
    
    func stopTimer(){
        timer?.invalidate()
        
        gameProcessor.updateTime(plus: runCount)
        runCount = 0
        
        saveInfoIfNedded()
    }
    
    // MARK: - Update UI
    func displayAllNumbers() {
        displayOpenedNumbers()
        displayNotes()
    }
    
    private func displayOpenedNumbers() {
        let openedNumbers = gameProcessor.gameState.openedNumbers
        let originallyOpenedNumbers = gameProcessor.gameState.originallyOpenedNumbers
        
        for i in Constants.sudokuRange {
            for j in Constants.sudokuRange {
                if openedNumbers[i][j] != 0 {
                    
                    if openedNumbers[i][j] == -1 {
                        self.filledNumbersLabels[i][j].text = "-"
                    } else if gameSettings.fillElements == .ints {
                        self.filledNumbersLabels[i][j].text = String(openedNumbers[i][j])
                    } else {
                        self.filledNumbersLabels[i][j].text = String(Character(UnicodeScalar(openedNumbers[i][j] + 64)!))
                    }
                    
                    self.filledNumbersLabels[i][j].textColor = .lightBlue
                    
                    if openedNumbers[i][j] != gameProcessor.gameState.sudokuNumbers[i][j] && openedNumbers[i][j] != -1 {
                        if UserDefaults.standard.bool(forKey: Settings.autoCheckMistakes.rawValue) {
                            self.filledNumbersLabels[i][j].textColor = .red
                        }
                    }
                    
                    if originallyOpenedNumbers[i][j] != 0 {
                        self.filledNumbersLabels[i][j].textColor = .lightPink
                    }
                } else {
                    self.filledNumbersLabels[i][j].text = ""
                }
            }
        }
    }
    
    func displayNotes() {
        let notesNumbers = gameProcessor.gameState.notesNumbers
        
        for i in Constants.sudokuRange {
            for j in Constants.sudokuRange {
                for k in Constants.sudokuNumbersRange {
                    if notesNumbers[i][j][k] == true {
                        if gameSettings.fillElements == .ints {
                            self.notesLabels[i][j][k - 1].text = String(k)
                        } else {
                            self.notesLabels[i][j][k - 1].text = String(Character(UnicodeScalar(k + 64)!))
                        }
                    } else {
                        self.notesLabels[i][j][k - 1].text = ""
                    }
                }
            }
        }
    }
    
    func addTipsCount() {
        let tipsStackView = sudokuPanelStackView.arrangedSubviews[3] as? UIStackView
        let tipLabel = tipsStackView?.arrangedSubviews[1] as? UILabel
        tipLabel?.text = NSLocalizedString("Tip", comment: "") + " (\(gameProcessor.gameState.tips))"
    }
    
    func addGameMode() {
        let modeLabel = timeModeStackView.arrangedSubviews[0] as? UILabel
        modeLabel?.text = NSLocalizedString(gameProcessor.gameState.gameLevel.rawValue, comment: "")
    }
    
    // MARK: - Users Taps on UI Elements
    @objc func tapOnGrid(_ sender: UITapGestureRecognizer) {
        let touchX = Double(sender.location(in: gridView).x)
        let touchY = Double(sender.location(in: gridView).y)
        
        gridView.addSubview(selectedCellView)
        gridView.sendSubviewToBack(selectedCellView)
        
        selectedCellView.frame = CGRect(x: floor(touchX / gameSettings.cellSize) * gameSettings.cellSize, y: floor(touchY / gameSettings.cellSize) * gameSettings.cellSize, width: gameSettings.cellSize, height: gameSettings.cellSize)
        selectedCellView.backgroundColor = .lightPink.withAlphaComponent(0.3)
    }
    
    @objc func tapPanelButtonCancel(sender: UIButton!) {
        if let lastAction = gameProcessor.sudokuActions.popLast() {
            let x = lastAction.xCell
            let y = lastAction.yCell
            let num = lastAction.lastNumber
            
            if gameProcessor.gameState.originallyOpenedNumbers[x][y] == 0 {
                if lastAction.note {
                    if lastAction.isAddNote {
                        gameProcessor.gameState.notesNumbers[x][y][num] = false
                    } else {
                        gameProcessor.gameState.notesNumbers[x][y] = lastAction.noteStack!
                    }
                } else {
                    gameProcessor.gameState.openedNumbers[x][y] = lastAction.lastNumber
                }
                
                if lastAction.isUndoPreviousAction {
                    tapPanelButtonCancel(sender: sender)
                }
            } else {
                tapPanelButtonCancel(sender: sender)
            }
            
            saveInfoIfNedded()
            displayAllNumbers()
        }
    }
    
    @objc func tapPanelButtonDelete(sender: UIButton!) {
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (x, y) = getCellsByCoordinates()
        
        if gameProcessor.gameState.openedNumbers[x][y] != 0 {
            gameProcessor.addAction(SudokuAction(xCell: x, yCell: y, lastNumber: gameProcessor.gameState.openedNumbers[x][y]))
            _ = gameProcessor.deleteCellNumber(x: x, y: y)
        }
        
        if !gameProcessor.isNotesEmpty(x: x, y: y) {
            gameProcessor.addAction(SudokuAction(xCell: x, yCell: y, lastNumber: 0, note: true, isAddNote: false, noteStack: gameProcessor.gameState.notesNumbers[x][y]))
            gameProcessor.clearCellNotes(x: x, y: y)
        }
        
        saveInfoIfNedded()
        displayAllNumbers()
    }
    
    
    @objc func tapPanelButtonNote(sender: UIButton!) {
        gameProcessor.isNote = !gameProcessor.isNote
        
        for i in 0..<numberPanelStackView.arrangedSubviews.count {
            let button = numberPanelStackView.arrangedSubviews[i] as? UIButton
            button?.isSelected = gameProcessor.isNote
        }
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!) {
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (x, y) = getCellsByCoordinates()
        
        if gameProcessor.gameState.tips > 0 {
            gameProcessor.decreaseTipsNumbers()
            
            if !gameProcessor.isNotesEmpty(x: x, y: y) {
                gameProcessor.clearCellNotes(x: x, y: y)
            }
            gameProcessor.gameState.openedNumbers[x][y] = gameProcessor.fillCellbyRightNumber(x: x, y: y)
        }
        
        addTipsCount()
        
        saveInfoIfNedded()
        displayAllNumbers()
        transitionIfAllCellsFilled()
    }
    
    
    // MARK: - Users Taps on Numbers Panel
    @objc func tapNumberPanelButton(sender: UIButton!){
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (x, y) = getCellsByCoordinates()
        
        if gameProcessor.isNote && sender.tag != -1 {
            fillCellByNote(x: x, y: y, value: sender.tag)
        } else {
            fillCellByNumber(x: x, y: y, value: sender.tag)
        }
        
        saveInfoIfNedded()
        displayAllNumbers()
        transitionIfAllCellsFilled()
    }
    
    func fillCellByNote(x: Int, y: Int, value: Int) {
        var isUndoPrevious: Bool = false
        if gameProcessor.gameState.openedNumbers[x][y] != 0 {
            gameProcessor.addAction(SudokuAction(xCell: x, yCell: y, lastNumber: gameProcessor.gameState.openedNumbers[x][y]))
            
            _ = gameProcessor.deleteCellNumber(x: x, y: y)
            
            isUndoPrevious = true
        }
        
        gameProcessor.addAction(SudokuAction(xCell: x, yCell: y, lastNumber: value, note: true, isUndoPreviousAction: isUndoPrevious))
        _ = gameProcessor.fillCellByNote(x: x, y: y, value: value)
    }
    
    func fillCellByNumber(x: Int, y: Int, value: Int) {
        if gameProcessor.gameState.openedNumbers[x][y] != value {
            var isUndoPrevious: Bool = false
            if !gameProcessor.isNotesEmpty(x: x, y: y) {
                gameProcessor.addAction(SudokuAction(xCell: x, yCell: y, lastNumber: 0, note: true, isAddNote: false,
                                                     noteStack: gameProcessor.gameState.notesNumbers[x][y]))
                
                gameProcessor.clearCellNotes(x: x, y: y)
                isUndoPrevious = true
            }
            
            gameProcessor.addAction(SudokuAction(xCell: x, yCell: y, lastNumber: gameProcessor.gameState.openedNumbers[x][y],
                                                 isUndoPreviousAction: isUndoPrevious))
            _ = gameProcessor.fillCell(x: x, y: y, value: value)
        }
    }
    
    // MARK: - End Game
    private func transitionIfAllCellsFilled() {
        if gameProcessor.checkIfAllCellsFilled() {
            stopTimer()
            transitionToCompleteVC(isWin: gameProcessor.checkIfAllCellsRight())
        } else {
            if gameProcessor.checkIfAllCellsRight() {
                stopTimer()
                transitionToCompleteVC(isWin: true)
            }
        }
    }
    
    private func transitionToCompleteVC(isWin: Bool) {
        let completeVC = CompleteViewController()
        
        completeVC.configureCompleteVC(isWin: isWin, time: gameProcessor.gameState.time, gameName: gameProcessor.gameState.gameName,
                                       isSaving: gameSettings.isSaving, level: gameProcessor.gameState.gameLevel)
        
        self.isTransitionToCompleteVC!(completeVC)
        
        completeVC.startOver = { start in
            self.startGameOver()
        }
        
        completeVC.continueGame = { continueGame in
            self.continueCurrentGame()
        }
    }
    
    func startGameOver() {
        runTimer()
        gameProcessor.resetTimer()
        
        for i in Constants.sudokuRange {
            for j in Constants.sudokuRange {
                if gameProcessor.gameState.originallyOpenedNumbers[i][j] == 0 {
                    _ = gameProcessor.fillCell(x: i, y: j, value: 0)
                    gameProcessor.gameState.openedNumbers[i][j] = 0
                }
            }
        }
        saveInfoIfNedded()
    }
    
    func continueCurrentGame() {
        runTimer()
        saveInfoIfNedded()
    }
    
    // MARK: - Calculations
    private func getCellsByCoordinates() -> (x: Int, y: Int) {
        let x = Int(floor(selectedCellView.frame.midX / gameSettings.cellSize))
        let y = Int(floor(selectedCellView.frame.midY / gameSettings.cellSize))
        return (x, y)
    }
    
    func saveInfoIfNedded() {
        if gameSettings.isSaving {
            gamesInfoCoding.saveGameInfo(game: gameProcessor.gameState)
        }
    }
}
