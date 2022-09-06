//
//  DotsSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.06.2022.
//

import UIKit

class DotsSudokuViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: Int] = [.easy: 12, .medium: 7, .hard: 3, .expert: 0]
    
    override func viewDidLoad() {
        super.gameSettings.gameName = .dotsSudoku
        super.gameSettings.openedNum = openedNumsLevels[super.gameSettings.gameLevel] ?? openedNumsLevels[.easy] ?? 12
        
        
        super.viewDidLoad()
        
        configureDots()
    }
    
    func configureDots() {
        let sudokuNumbers = super.gameController.gameProcessor.gameState.sudokuNumbers
        let gridView = super.gameController.gridView

        for i in Constants.sudokuRange {
            for j in Constants.sudokuHalfRange {
                for k in 1...2 {

                    var a = sudokuNumbers[i][j]
                    var b = sudokuNumbers[i][j + 1]

                    var pointCenter = CGPoint(x: Double(i) * gameSettings.cellSize + gameSettings.cellSize / 2, y: (Double(j) + 1) * gameSettings.cellSize)

                    if k == 2 {
                        a = sudokuNumbers[j][i]
                        b = sudokuNumbers[j + 1][i]
                        pointCenter = CGPoint(x: (Double(j) + 1) * gameSettings.cellSize, y: Double(i) * gameSettings.cellSize + gameSettings.cellSize / 2)
                    }


                    if ifTwoNumbersDiffersInOne(a: a, b: b) {
                        let dotView = WhiteDot()
                        dotView.configureDot(cellSize: gameSettings.cellSize)

                        dotView.center = gridView.convert(pointCenter, from: gridView)
                        gridView.addSubview(dotView)
                    }

                    if ifTwoNumbersDifferTwice(a: a, b: b) {
                        let dotView = BlackDot()
                        dotView.configureDot(cellSize: gameSettings.cellSize)

                        dotView.center = gridView.convert(pointCenter, from: gridView)
                        gridView.addSubview(dotView)
                    }
                    
                    if ifTwoNumbersDifferTwice(a: a, b: b) && ifTwoNumbersDiffersInOne(a: a, b: b) {
                        if Bool.random() {
                            let dotView = WhiteDot()
                            dotView.configureDot(cellSize: gameSettings.cellSize)

                            dotView.center = gridView.convert(pointCenter, from: gridView)
                            gridView.addSubview(dotView)
                        }
                    }
                }
            }
        }
    }

    func ifTwoNumbersDiffersInOne(a: Int, b: Int) -> Bool {
        if a == b + 1 || a == b - 1 {
            return true
        }
        return false
    }

    func ifTwoNumbersDifferTwice(a: Int, b: Int) -> Bool {
        if Double(a) == Double(b) / 2 || Double(a) == Double(b) * 2 {
            return true
        }
        return false
    }
}
