//
//  KillerSudokuCellsViews.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 13.08.2022.
//

import UIKit

class SquareCellView: UIView {
    func configureCell(cellSize: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
        
        let gap = cellSize / 10

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 6/15 * cellSize, y: gap))
        path.addLine(to: CGPoint(x: cellSize - gap, y: gap))
        path.addLine(to: CGPoint(x: cellSize - gap, y: cellSize - gap))
        path.addLine(to: CGPoint(x: gap, y: cellSize - gap))
        path.addLine(to: CGPoint(x: gap, y: 6/15 * cellSize))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 0.5
        
        self.layer.addSublayer(shapeLayer)
    }
}

class RecessCellView: UIView {
    func configureCell(cellSize: CGFloat, isEmptyArea: Bool, isLeft: Bool) {
        self.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
        
        let gap = cellSize / 10
        
        var gapForEmptyAreaX = gap
        var gapForEmptyAreaY = gap
        
        let path = UIBezierPath()
        
        if isEmptyArea {
            gapForEmptyAreaX = 6/15 * cellSize
            gapForEmptyAreaY = 5/15 * cellSize
        }
        
        if isLeft {
            path.move(to: CGPoint(x: cellSize, y: gap))
            path.addLine(to: CGPoint(x: gap, y: gap))
            path.addLine(to: CGPoint(x: gap, y: cellSize - gapForEmptyAreaX))
            path.move(to: CGPoint(x: gapForEmptyAreaY, y: cellSize - gap))
            path.addLine(to: CGPoint(x: cellSize, y: cellSize - gap))
        } else {
            path.move(to: CGPoint(x: cellSize, y: gap))
            path.addLine(to: CGPoint(x: gapForEmptyAreaX, y: gap))
            path.move(to: CGPoint(x: gap, y: gapForEmptyAreaY))
            path.addLine(to: CGPoint(x: gap, y: cellSize - gap))
            path.addLine(to: CGPoint(x: cellSize, y: cellSize - gap))
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 0.5
        
        self.layer.addSublayer(shapeLayer)
    }
}

class AngleCellView: UIView {
    func configureCell(cellSize: CGFloat, isEmptyArea: Bool) {
        self.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
        
        let gap = cellSize / 10
        
        var gapForEmptyAreaX = gap
        var gapForEmptyAreaY = gap
        
        if isEmptyArea {
            gapForEmptyAreaX = 6/15 * cellSize
            gapForEmptyAreaY = 5/15 * cellSize
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: cellSize, y: gap))
        path.addLine(to: CGPoint(x: gapForEmptyAreaX, y: gap))
        path.move(to: CGPoint(x: gap, y: gapForEmptyAreaY))
        path.addLine(to: CGPoint(x: gap, y: cellSize))
        path.move(to: CGPoint(x: cellSize - gap, y: cellSize))
        path.addLine(to: CGPoint(x: cellSize - gap, y: cellSize - gap))
        path.addLine(to: CGPoint(x: cellSize, y: cellSize - gap))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 0.5
        
        self.layer.addSublayer(shapeLayer)
    }
}

class InsideAngleCellView: UIView {
    func configureCell(cellSize: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
        
        let gap = cellSize / 10
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: cellSize, y: gap))
        path.addLine(to: CGPoint(x: gap, y: gap))
        path.addLine(to: CGPoint(x: gap, y: cellSize))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 0.5
        
        self.layer.addSublayer(shapeLayer)
    }
}

class StraightCellView: UIView {
    func configureCell(cellSize: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
        
        let gap = cellSize / 10
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: gap))
        path.addLine(to: CGPoint(x: cellSize, y: gap))
        path.move(to: CGPoint(x: cellSize, y: cellSize - gap))
        path.addLine(to: CGPoint(x: 0, y: cellSize - gap))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 0.5
        
        self.layer.addSublayer(shapeLayer)
    }
}

class TShapeCellView: UIView {
    func configureCell(cellSize: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
        
        let gap = cellSize / 10
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: gap))
        path.addLine(to: CGPoint(x: cellSize, y: gap))
        path.move(to: CGPoint(x: cellSize, y: cellSize - gap))
        path.addLine(to: CGPoint(x: cellSize - gap, y: cellSize - gap))
        path.addLine(to: CGPoint(x: cellSize - gap, y: cellSize))
        path.move(to: CGPoint(x: gap, y: cellSize))
        path.addLine(to: CGPoint(x: gap, y: cellSize - gap))
        path.addLine(to: CGPoint(x: 0, y: cellSize - gap))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 0.5
        
        self.layer.addSublayer(shapeLayer)
    }
}

class CrossCellView: UIView {
    func configureCell(cellSize: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
        
        let gap = cellSize / 10
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: gap))
        path.addLine(to: CGPoint(x: gap, y: gap))
        path.addLine(to: CGPoint(x: gap, y: 0))
        path.move(to: CGPoint(x: cellSize - gap, y: 0))
        path.addLine(to: CGPoint(x: cellSize - gap, y: gap))
        path.addLine(to: CGPoint(x: cellSize, y: gap))
        path.move(to: CGPoint(x: cellSize, y: cellSize - gap))
        path.addLine(to: CGPoint(x: cellSize - gap, y: cellSize - gap))
        path.addLine(to: CGPoint(x: cellSize - gap, y: cellSize))
        path.move(to: CGPoint(x: gap, y: cellSize))
        path.addLine(to: CGPoint(x: gap, y: cellSize - gap))
        path.addLine(to: CGPoint(x: 0, y: cellSize - gap))

        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 0.5
        
        self.layer.addSublayer(shapeLayer)
    }
}
