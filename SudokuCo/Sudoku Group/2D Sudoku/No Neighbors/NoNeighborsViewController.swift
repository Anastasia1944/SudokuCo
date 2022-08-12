//
//  NoNeighborsViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class NoNeighborsViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [String: CGFloat] = ["Easy": 30, "Medium": 25, "Hard": 20, "Expert": 15]
    
    override func viewDidLoad() {
        super.configureInit()
        super.gameName = "No Neighbors"
        super.sudokuType = .sudoku2D
        super.withBoldAreas = false
        super.openedNum = openedNumsLevels[gameMode] ?? openedNumsLevels["Easy"]!
        
        super.viewDidLoad()
        
        addBoldLines()
    }
    
    private func addBoldLines() {
        let sudokuNumbers = super.generalSudokuController.getSudokuNumbers()
        
        for i in 0...8 {
            for j in 0..<8 {
                for k in 1...2 {
                    var a = sudokuNumbers[i][j]
                    var b = sudokuNumbers[i][j + 1]
                    
                    var pointCenter = CGPoint(x: CGFloat(i) * cellSize + cellSize / 2, y: (CGFloat(j) + 1) * cellSize)
                    
                    let boldLine = BoldLine()
                    boldLine.configureBoldLine(cellSize: cellSize)
                    
                    if k == 2 {
                        a = sudokuNumbers[j][i]
                        b = sudokuNumbers[j + 1][i]
                        pointCenter = CGPoint(x: (CGFloat(j) + 1) * cellSize, y: CGFloat(i) * cellSize + cellSize / 2)
                        boldLine.transform = boldLine.transform.rotated(by: .pi * 1.5)
                    }
                    
                    if ifTwoNumbersDiffersInOne(a: a, b: b) {
                        boldLine.center = gridView.convert(pointCenter, from: gridView)
                        gridView.addSubview(boldLine)
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
}
