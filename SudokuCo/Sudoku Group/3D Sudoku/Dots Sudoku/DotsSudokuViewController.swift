//
//  DotsSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.06.2022.
//

import UIKit

class DotsSudokuViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: CGFloat] = [.easy: 12, .medium: 7, .hard: 3, .expert: 0]
    
    override func viewDidLoad() {
        super.configureInit()
        super.gameName = "Dots Sudoku"
        super.openedNum = openedNumsLevels[gameLevel] ?? openedNumsLevels[.easy] ?? 12
        super.viewDidLoad()
        
        configureDots()
    }
    
    func configureDots() {

        let sudokuNumbers = generalSudokuController.getSudokuNumbers()

        for i in 0...8 {
            for j in 0..<8 {
                for k in 1...2 {

                    var a = sudokuNumbers[i][j]
                    var b = sudokuNumbers[i][j + 1]

                    var pointCenter = CGPoint(x: CGFloat(i) * cellSize + cellSize / 2, y: (CGFloat(j) + 1) * cellSize)

                    if k == 2 {
                        a = sudokuNumbers[j][i]
                        b = sudokuNumbers[j + 1][i]
                        pointCenter = CGPoint(x: (CGFloat(j) + 1) * cellSize, y: CGFloat(i) * cellSize + cellSize / 2)
                    }


                    if ifTwoNumbersDiffersInOne(a: a, b: b) {
                        let dotView = WhiteDot()
                        dotView.configureDot(cellSize: cellSize)

                        dotView.center = gridView.convert(pointCenter, from: gridView)
                        gridView.addSubview(dotView)
                    }

                    if ifTwoNumbersDifferTwice(a: a, b: b) {
                        let dotView = BlackDot()
                        dotView.configureDot(cellSize: cellSize)

                        dotView.center = gridView.convert(pointCenter, from: gridView)
                        gridView.addSubview(dotView)
                    }
                    
                    if ifTwoNumbersDifferTwice(a: a, b: b) && ifTwoNumbersDiffersInOne(a: a, b: b) {
                        if Bool.random() {
                            let dotView = WhiteDot()
                            dotView.configureDot(cellSize: cellSize)

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
