//
//  EasyAsABCViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 11.09.2022.
//

import UIKit

enum Direction {
    case up, down, left, right
}

class EasyAsABCViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 15, .medium: 11, .hard: 6, .expert: 3]
    private let openedLettersRange: [DifficultyLevels: ClosedRange<Int>] = [.easy: 1...6, .medium: 1...6, .hard: 1...5, .expert: 1...5]
    private let removedLettersCount: [DifficultyLevels: Int] = [.easy: 0, .medium: 2, .hard: 4, .expert: 6]
    
    var surroundingNumbersLabels: [[UILabel]] = []
    
    override func viewDidLoad() {
        super.gameSettings.gameName = .easyAsABC
        super.gameSettings.sudokuType = .sudoku2D
        super.gameSettings.withBoldAreas = false
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 15
        super.gameSettings.gridWidth = Double(((UIScreen.main.bounds.width - 20) / 11) * 9)
        super.gameSettings.cellSize = super.gameSettings.gridWidth / 9
        super.gameSettings.whichNumsSaved = openedLettersRange[super.gameSettings.gameLevel] ?? openedLettersRange[.easy] ?? 1...6
        super.gameSettings.fillElements = .letters
        
        super.viewDidLoad()
        
        configureSurroundingNumbersOfGrid()
        removeLetters()
    }
    
    func configureSurroundingNumbersOfGrid() {
        surroundingNumbersLabels = [[], [], [], []]
        let gridView = super.gameController.gridView
        
        for i in Constants.sudokuRange {
            let label = UILabel(frame: CGRect(x: Double(i) * super.gameSettings.cellSize, y: -super.gameSettings.cellSize, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .lightBlue
            label.text = findNearestLetter(x: i, y: 0, direction: .down)
            
            surroundingNumbersLabels[0].append(label)
            gridView.addSubview(label)
            
        }
        
        for i in Constants.sudokuRange {
            
            let label = UILabel(frame: CGRect(x: super.gameSettings.cellSize * 9, y: Double(i) * super.gameSettings.cellSize, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .lightBlue
            label.text = findNearestLetter(x: 8, y: i, direction: .left)
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
            
        }
        
        for i in Constants.sudokuRange {
            
            let label = UILabel(frame: CGRect(x: Double(i) * super.gameSettings.cellSize, y: super.gameSettings.cellSize * 9, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .lightBlue
            label.text = findNearestLetter(x: i, y: 8, direction: .up)
            
            surroundingNumbersLabels[2].append(label)
            gridView.addSubview(label)
            
        }
        
        for i in Constants.sudokuRange {
            
            let label = UILabel(frame: CGRect(x: -super.gameSettings.cellSize, y: Double(i) * super.gameSettings.cellSize, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .lightBlue
            label.text = findNearestLetter(x: 0, y: i, direction: .right)
            
            surroundingNumbersLabels[3].append(label)
            gridView.addSubview(label)
            
        }
    }
    
    func findNearestLetter(x: Int, y: Int, direction: Direction) -> String {
        let sudokuNumbers = super.gameController.gameProcessor.gameState.sudokuNumbers
        var x = x
        var y = y
        
        for _ in Constants.sudokuRange {
            if sudokuNumbers[x][y] != 0 {
                return String(UnicodeScalar(sudokuNumbers[x][y] + 64)!)
            }
            switch direction {
            case .up:
                y -= 1
            case .down:
                y += 1
            case .left:
                x -= 1
            case .right:
                x += 1
            }
        }
        return "A"
    }
    
    func removeLetters() {
        let removingCount = removedLettersCount[super.gameSettings.gameLevel] ?? 0
        
        for _ in 0..<removingCount {
            let side = Int.random(in: 0...3)
            let letterNum = Int.random(in: Constants.sudokuRange)
            
            surroundingNumbersLabels[side][letterNum].text = ""
        }
    }
}
