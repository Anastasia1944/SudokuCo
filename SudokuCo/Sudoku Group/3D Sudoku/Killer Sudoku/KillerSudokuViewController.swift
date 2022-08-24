//
//  KillerSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 13.08.2022.
//

import UIKit

class KillerSudokuViewController: GeneralSudokuViewController {
    
    private let openedNumsLevels: [DifficultyLevels: CGFloat] = [.easy: 15, .medium: 10, .hard: 5, .expert: 0]
    
    private var killerSudokuController = KillerSudokuController()
    
    private var killerSudokuAreas: [[Int]] = []
    private var areasSum: [[Int]] = []

    override func viewDidLoad() {
        super.configureInit()
        super.gameName = "Killer Sudoku"
        super.gapNotesShift = 5
        super.openedNum = openedNumsLevels[gameLevel] ?? openedNumsLevels[.easy] ?? 15

        super.viewDidLoad()
        
        let sudokuNumbers = generalSudokuController.getSudokuNumbers()
        killerSudokuAreas = killerSudokuController.getKillerSudokuAreas(sudokuNumbers: sudokuNumbers)
        
        areasSum = killerSudokuController.getAreasSum()
        
        drawKillerCells()
        drawTipsAreas()
    }
    
    func drawKillerCells() {
        for i in 0...8 {
            for j in 0...8 {
                let pointCenter = CGPoint(x: CGFloat(i) * cellSize + 1/2 * cellSize, y: CGFloat(j) * cellSize + 1/2 * cellSize)
                
                if killerSudokuAreas[i][j] == 0 {
                    continue
                }
                switch checkNeighbors(i: i, j: j) {
                case (false, false, false, false):
                    drawSquare(i: i, j: j, center: pointCenter)
                case (true, false, false, false):
                    drawRecess(i: i, j: j, center: pointCenter, rotate: 1.5)
                case (false, true, false, false):
                    drawRecess(i: i, j: j, center: pointCenter, rotate: 0, isLeft: false)
                case (false, false, true, false):
                    drawRecess(i: i, j: j, center: pointCenter, rotate: 0.5)
                case (false, false, false, true):
                    drawRecess(i: i, j: j, center: pointCenter, rotate: 1.0)
                case (true, false, true, false):
                    drawStraignt(i: i, j: j, center: pointCenter, rotate: 0.5)
                case (false, true, false, true):
                    drawStraignt(i: i, j: j, center: pointCenter, rotate: 0)
                case (true, true, false, false):
                    drawAngle(i: i, j: j, center: pointCenter, rotate: 1.5)
                case (false, true, true, false):
                    drawAngle(i: i, j: j, center: pointCenter, rotate: 0)
                case (false, false, true, true):
                    drawAngle(i: i, j: j, center: pointCenter, rotate: 0.5)
                case (true, false, false, true):
                    drawAngle(i: i, j: j, center: pointCenter, rotate: 1.0)
                case (true, true, true, false):
                    drawTShape(i: i, j: j, center: pointCenter, rotate: 1.5)
                case (false, true, true, true):
                    drawTShape(i: i, j: j, center: pointCenter, rotate: 0)
                case (true, false, true, true):
                    drawTShape(i: i, j: j, center: pointCenter, rotate: 0.5)
                case (true, true, false, true):
                    drawTShape(i: i, j: j, center: pointCenter, rotate: 1.0)
                case (true, true, true, true):
                    drawCross(i: i, j: j, center: pointCenter)
                }
            }
        }
    }
    
    private func checkNeighbors(i: Int, j: Int) -> (Bool, Bool, Bool, Bool) {
        var up = false
        var right = false
        var down = false
        var left = false
        
        if j != 0 {
            up = killerSudokuAreas[i][j] == killerSudokuAreas[i][j - 1] ? true : false
        }
        
        if i != 8 {
            right = killerSudokuAreas[i][j] == killerSudokuAreas[i + 1][j] ? true : false
        }
        
        if j != 8 {
            down = killerSudokuAreas[i][j] == killerSudokuAreas[i][j + 1] ? true : false
        }
        
        if i != 0 {
            left = killerSudokuAreas[i][j] == killerSudokuAreas[i - 1][j] ? true : false
        }
        
        return (up, right, down, left)
    }
    
    private func drawSquare(i: Int, j: Int, center: CGPoint) {
        let squareCellView = SquareCellView()
        squareCellView.configureCell(cellSize: cellSize)

        squareCellView.center = gridView.convert(center, from: gridView)
        gridView.addSubview(squareCellView)
    }
    
    private func drawRecess(i: Int, j: Int, center: CGPoint, rotate: Double, isLeft: Bool = true) {
        let recessCellView = RecessCellView()
        
        if areasSum[i][j] != 0 {
            recessCellView.configureCell(cellSize: cellSize, isEmptyArea: true, isLeft: isLeft)
        } else {
            recessCellView.configureCell(cellSize: cellSize, isEmptyArea: false, isLeft: true)
        }
        recessCellView.transform = recessCellView.transform.rotated(by: .pi * rotate)

        recessCellView.center = gridView.convert(center, from: gridView)
        gridView.addSubview(recessCellView)
    }
    
    private func drawStraignt(i: Int, j: Int, center: CGPoint, rotate: Double) {
        let straightCellView = StraightCellView()
        straightCellView.configureCell(cellSize: cellSize)
        straightCellView.transform = straightCellView.transform.rotated(by: .pi * rotate)

        straightCellView.center = gridView.convert(center, from: gridView)
        gridView.addSubview(straightCellView)
    }
    
    private func drawAngle(i: Int, j: Int, center: CGPoint, rotate: Double) {
        let angleCellView = AngleCellView()
        
        if areasSum[i][j] != 0 {
            angleCellView.configureCell(cellSize: cellSize, isEmptyArea: true)
        } else {
            angleCellView.configureCell(cellSize: cellSize, isEmptyArea: false)
        }
        angleCellView.transform = angleCellView.transform.rotated(by: .pi * rotate)

        angleCellView.center = gridView.convert(center, from: gridView)
        gridView.addSubview(angleCellView)
    }
    
    private func drawTShape(i: Int, j: Int, center: CGPoint, rotate: Double) {
        let tShapeCellView = TShapeCellView()
        tShapeCellView.configureCell(cellSize: cellSize)
        tShapeCellView.transform = tShapeCellView.transform.rotated(by: .pi * rotate)

        tShapeCellView.center = gridView.convert(center, from: gridView)
        gridView.addSubview(tShapeCellView)
    }
    
    private func drawCross(i: Int, j: Int, center: CGPoint) {
        let crossCellView = CrossCellView()
        crossCellView.configureCell(cellSize: cellSize)

        crossCellView.center = gridView.convert(center, from: gridView)
        gridView.addSubview(crossCellView)
    }
    
    private func drawTipsAreas() {
        for i in 0...8 {
            for j in 0...8 {
                if areasSum[i][j] != 0 {
                    let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize + cellSize / 30, y: CGFloat(j) * cellSize + cellSize / 30, width: cellSize / 3, height: cellSize / 5))
                    label.text = String(areasSum[i][j])
                    label.font = .systemFont(ofSize: 10)
                    label.textColor = .blueSys
                    label.textAlignment = .center
                    
                    gridView.addSubview(label)
                }
            }
        }
    }
}
