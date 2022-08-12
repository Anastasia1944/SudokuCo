//
//  BoldLine.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

class BoldLine: UIView {
    func configureBoldLine(cellSize: CGFloat) {
        
        self.frame = CGRect(x: 0, y: 0, width: cellSize / 2, height: cellSize / 8)
        
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: CGFloat(3))
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = path.cgPath
        
        self.layer.addSublayer(shapeLayer)
//        self.layer.mask = shape
    }
}
