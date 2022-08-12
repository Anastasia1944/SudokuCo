//
//  SudokuGrid.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class GridView: UIView {

    private var sudokuWidth = CGFloat(0)
    private var oneSquareSide = CGFloat(0)
    
    private var withOuterBoldBorder: Bool = true
    private var withBoldAreas: Bool = true
    private var cellsInTheArea: Int = 3
    
    private var cellsNumber = 9
    
    func formView(width: CGFloat, cellsNumber: Int = 9, withOuterBoldBorder: Bool = true, withBoldAreas: Bool = true, cellsInTheArea: Int = 3) {
        self.withOuterBoldBorder = withOuterBoldBorder
        self.withBoldAreas = withBoldAreas
        self.cellsNumber = cellsNumber
        
        sudokuWidth = width
        oneSquareSide = CGFloat(sudokuWidth / CGFloat(cellsNumber))
        
        self.drawLines()
    }
    
    private func drawLines() {
        let xVar = CGFloat(0)
        let yVar = CGFloat(0)
        
        for i in 0...cellsNumber {
            var borderWidth = CGFloat(0.2)
            
            if withOuterBoldBorder && [0, cellsNumber].contains(i) {
                borderWidth = 1.0
            }
            
            if withBoldAreas && i % cellsInTheArea == 0 {
                borderWidth = 1.0
            }
            
            let lineY = UIBezierPath()
            lineY.move(to: .init(x: xVar, y: yVar + CGFloat(i) * oneSquareSide))
            lineY.addLine(to: .init(x: xVar + sudokuWidth, y: yVar + CGFloat(i) * oneSquareSide))
            
            let shapeLayerY = CAShapeLayer()
            shapeLayerY.path = lineY.cgPath
            shapeLayerY.strokeColor = UIColor.black.cgColor
            shapeLayerY.lineWidth = borderWidth
            
            self.layer.addSublayer(shapeLayerY)
            
            
            let lineX = UIBezierPath()
            lineX.move(to: .init(x: xVar + CGFloat(i) * oneSquareSide, y: yVar))
            lineX.addLine(to: .init(x: xVar + CGFloat(i) * oneSquareSide, y: yVar + sudokuWidth))
            
            let shapeLayerX = CAShapeLayer()
            shapeLayerX.path = lineX.cgPath
            shapeLayerX.strokeColor = UIColor.black.cgColor
            shapeLayerX.lineWidth = borderWidth
            
            self.layer.addSublayer(shapeLayerX)
        }
    }
    
    func getCellSize() -> CGFloat {
        return oneSquareSide
    }
}

