//
//  SkyscrapersViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.09.2022.
//

import UIKit

class SkyscrapersViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 25, .medium: 17, .hard: 9, .expert: 3]
    private let removedLettersCount: [DifficultyLevels: Int] = [.easy: 0, .medium: 2, .hard: 4, .expert: 6]
    
    var surroundingNumbersLabels: [[UILabel]] = []

    override func viewDidLoad() {
        super.gameSettings.gameName = .skyscrapers
        super.gameSettings.sudokuType = .sudoku2D
        super.gameSettings.withBoldAreas = false
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 15
        super.gameSettings.gridWidth = Double(((UIScreen.main.bounds.width - 20) / 11) * 9)
        super.gameSettings.cellSize = super.gameSettings.gridWidth / 9
        
        super.viewDidLoad()
        
        configureSurroundingNumbersOfGrid()
        removeElements()
    }
    
    func configureSurroundingNumbersOfGrid() {
        surroundingNumbersLabels = [[], [], [], []]
        let gridView = super.gameController.gridView
        
        for i in Constants.sudokuRange {
            let label = UILabel(frame: CGRect(x: Double(i) * super.gameSettings.cellSize, y: -super.gameSettings.cellSize, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .darkBlue
            label.text = String(skyscrapersNumCount(x: i, y: 0, direction: .down))
            
            surroundingNumbersLabels[0].append(label)
            gridView.addSubview(label)
            
        }
        
        for i in Constants.sudokuRange {
            
            let label = UILabel(frame: CGRect(x: super.gameSettings.cellSize * 9, y: Double(i) * super.gameSettings.cellSize, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .darkBlue
            label.text = String(skyscrapersNumCount(x: 8, y: i, direction: .left))
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
            
        }
        
        for i in Constants.sudokuRange {
            
            let label = UILabel(frame: CGRect(x: Double(i) * super.gameSettings.cellSize, y: super.gameSettings.cellSize * 9, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .darkBlue
            label.text = String(skyscrapersNumCount(x: i, y: 8, direction: .up))
            
            surroundingNumbersLabels[2].append(label)
            gridView.addSubview(label)
            
        }
        
        for i in Constants.sudokuRange {
            
            let label = UILabel(frame: CGRect(x: -super.gameSettings.cellSize, y: Double(i) * super.gameSettings.cellSize, width: super.gameSettings.cellSize, height: super.gameSettings.cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .darkBlue
            label.text = String(skyscrapersNumCount(x: 0, y: i, direction: .right))
            
            surroundingNumbersLabels[3].append(label)
            gridView.addSubview(label)
            
        }
    }
    
    func skyscrapersNumCount(x: Int, y: Int, direction: Direction) -> Int {
        let sudokuNumbers = super.gameController.gameProcessor.gameState.sudokuNumbers
        var x = x
        var y = y
        var countSkyscrapers = 0
        var currentValue = 0
        
        for _ in Constants.sudokuRange {
            
            if sudokuNumbers[x][y] > currentValue {
                countSkyscrapers += 1
                currentValue = sudokuNumbers[x][y]
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
        return countSkyscrapers
    }
    
    func removeElements() {
        let removingCount = removedLettersCount[super.gameSettings.gameLevel] ?? 0
        
        for _ in 0..<removingCount {
            let side = Int.random(in: 0...3)
            let letterNum = Int.random(in: Constants.sudokuRange)
            
            surroundingNumbersLabels[side][letterNum].text = ""
        }
    }
}
