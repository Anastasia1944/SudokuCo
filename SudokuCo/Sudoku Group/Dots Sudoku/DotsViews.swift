//
//  DotsViews.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.06.2022.
//

import UIKit

class BlackDot: UIView {
    func configureDot(cellSize: CGFloat) {
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: CGFloat(cellSize / 6), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = UIColor.blackSys.cgColor
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
    }
}

class WhiteDot: UIView {
    func configureDot(cellSize: CGFloat) {
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: CGFloat(cellSize / 6), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = UIColor.whiteSys.cgColor
        shapeLayer.strokeColor = UIColor.blackSys.cgColor
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
    }
}
