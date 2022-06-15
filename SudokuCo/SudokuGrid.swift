//
//  SudokuGrid.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuGrid: UIView {
    let frameWidth = UIScreen.main.bounds.width
    let frameHeigh = UIScreen.main.bounds.height
    
    let gap = CGFloat(10)
    
    var oneSquareSide = CGFloat(0)
    var oneSmallSuareSide = CGFloat(0)
    var gridWidth = CGFloat(0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gridWidth = frameWidth - 2 * gap
        oneSquareSide = CGFloat(gridWidth / 9)
        
        drawLines()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawLines() {
        let xVar = gap
        let yVar = CGFloat((frameHeigh - frameWidth + 2 * gap) / 2)
        
        var height = CGFloat(0)
        var borderWidth = CGFloat(0)
        
        
        for i in 0...9 {
            if i % 3 == 0 {
                height = 1.0
                borderWidth = 1.0
            } else {
                height = 0.5
                borderWidth = 0.2
            }
            let lineViewY = UIView(frame: CGRect(x: xVar, y: yVar + CGFloat(i) * oneSquareSide, width: gridWidth, height: height))
            lineViewY.layer.borderWidth = borderWidth
            lineViewY.layer.borderColor = UIColor.black.cgColor
            self.addSubview(lineViewY)
            
            let lineViewX = UIView(frame: CGRect(x: xVar + CGFloat(i) * oneSquareSide, y: yVar, width: height, height: gridWidth))
            lineViewX.layer.borderWidth = borderWidth
            lineViewX.layer.borderColor = UIColor.black.cgColor
            self.addSubview(lineViewX)
        }
    }
}

