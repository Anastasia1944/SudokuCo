//
//  MoreLessSignView.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.06.2022.
//

import UIKit

class MoreLessSignView: UIView {
    
    func configureSign(cellSize: CGFloat) {
        
        self.frame = CGRect(x: 0, y: 0, width: cellSize / 2, height: cellSize / 4)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: cellSize / 4))
        path.addLine(to: CGPoint(x: cellSize / 4, y: 0))
        path.move(to: CGPoint(x: cellSize / 4, y: 0))
        path.addLine(to: CGPoint(x: cellSize / 2, y: cellSize / 4))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.blackSys.cgColor
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
    }
}
