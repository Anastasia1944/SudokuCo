//
//  SudokuGrid.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuGridView: UIView {
    
    private let frameWidth = UIScreen.main.bounds.width
    
    private var sudokuWidth = CGFloat(0)
    private var gap = CGFloat(0)
    private var oneSquareSide = CGFloat(0)
    
    func formView() {
        sudokuWidth = frameWidth - 2 * gap
        oneSquareSide = CGFloat(sudokuWidth / 9)
        self.drawLines()
    }
    
    func getCellSize() -> CGFloat {
        return oneSquareSide
    }
    
    func setGap(_ gap: CGFloat) {
        self.gap = gap
    }
    
    private func drawLines() {
        let xVar = CGFloat(0)
        let yVar = CGFloat(0)
        
        var borderWidth = CGFloat(0)
        
        for i in 0...9 {
            if i % 3 == 0 {
                borderWidth = 1.0
            } else {
                borderWidth = 0.2
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
}

