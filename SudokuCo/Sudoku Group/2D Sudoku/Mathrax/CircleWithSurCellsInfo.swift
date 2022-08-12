//
//  CircleWithSurCellsInfo.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import UIKit

enum CircleType {
    case multiply
    case division
    case sum
    case difference
    case even
    case odd
}

class CircleWithSurCellsInfo: UIView {
    
    let types: [CircleType: String] = [.multiply: "*", .difference: "-", .division: "/", .sum: "+", .even: "E", .odd: "O"]
    
    func configureCircle(cellSize: CGFloat, circleType: CircleType, value: String) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: CGFloat(cellSize / 4), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = UIColor.whiteSys.cgColor
        shapeLayer.strokeColor = UIColor.blackSys.cgColor
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cellSize, height: cellSize))
        label.center = self.center
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.text = value + types[circleType]!
        self.addSubview(label)
    }
}
