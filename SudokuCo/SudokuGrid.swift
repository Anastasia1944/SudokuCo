//
//  SudokuGrid.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuGrid: UIView {
    let frameWidth = UIScreen.main.bounds.width
    var frameHeigh = UIScreen.main.bounds.height
    
    let gap = CGFloat(10)
    
    var oneSquareSide = CGFloat(0)
    var gridWidth = CGFloat(0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gridWidth = frameWidth - 2 * gap
        oneSquareSide = CGFloat(gridWidth / 9)
        frameHeigh = frameHeigh - 100
        
        drawLines()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawLines() {
        let xVar = gap
        let yVar = CGFloat((frameHeigh - frameWidth + 2 * gap) / 2)
        
        var borderWidth = CGFloat(0)
        
        for i in 0...9 {
            if i % 3 == 0 {
                borderWidth = 1.0
            } else {
                borderWidth = 0.2
            }
            
            let lineY = UIBezierPath()
            lineY.move(to: .init(x: xVar, y: yVar + CGFloat(i) * oneSquareSide))
            lineY.addLine(to: .init(x: xVar + gridWidth, y: yVar + CGFloat(i) * oneSquareSide))
            
            let shapeLayerY = CAShapeLayer()
            shapeLayerY.path = lineY.cgPath
            shapeLayerY.strokeColor = UIColor.black.cgColor
            shapeLayerY.lineWidth = borderWidth
            
            self.layer.addSublayer(shapeLayerY)
            
            
            let lineX = UIBezierPath()
            lineX.move(to: .init(x: xVar + CGFloat(i) * oneSquareSide, y: yVar))
            lineX.addLine(to: .init(x: xVar + CGFloat(i) * oneSquareSide, y: yVar + gridWidth))
            
            let shapeLayerX = CAShapeLayer()
            shapeLayerX.path = lineX.cgPath
            shapeLayerX.strokeColor = UIColor.black.cgColor
            shapeLayerX.lineWidth = borderWidth
            
            self.layer.addSublayer(shapeLayerX)
        }
    }
}

