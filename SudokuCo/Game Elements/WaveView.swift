//
//  WaveView.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 25.09.2022.
//

import UIKit

class WaveView: UIView {
    
    private weak var displayLink: CADisplayLink?
    private var startTime: CFTimeInterval = 0
    
    var strokeColor: UIColor = .darkBlue
    
    var speed = 10
    var time = 0.0
    var frequency = 9.0
    var median = 100.0
    
    var A = 20.0
    var a1 = 20.0
    var a2 = 30.0
    var a3 = 10.0
    
    var B = 40.0
    var b1 = -10.0
    var b2 = 25.0
    var b3 = -20.0

    func animationStart() {
        randomSettings()
        startTime = CACurrentMediaTime()
        self.displayLink?.invalidate()
        let displayLink = CADisplayLink(target: self, selector:#selector(handleDisplayLink(_:)))
        displayLink.add(to: .main, forMode: .common)
        self.displayLink = displayLink
    }
    
    private func randomSettings() {
        A = Double.random(in: 1.0...100.0)
        a1 = Double.random(in: 1.0...100.0)
        a2 = Double.random(in: 1.0...100.0)
        a3 = Double.random(in: 1.0...100.0)
        
        B = Double.random(in: 1.0...100.0)
        b1 = Double.random(in: 1.0...100.0)
        b2 = Double.random(in: 1.0...100.0)
        b3 = Double.random(in: 1.0...100.0)
        
        frequency = Double.random(in: 2.0...12.0)
        speed = Int.random(in: 5...20)
        
        median = Double.random(in: -100.0...100.0)
    }
    
    @objc private func handleDisplayLink(_ displayLink: CADisplayLink) {
        self.time = (CACurrentMediaTime() - startTime) 
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.setNeedsDisplay()
    }
    
    private func stopDisplayLink() {
        displayLink?.invalidate()
    }
    
    override func draw(_ rect: CGRect) {
        let width = Double(self.frame.width)
        let height = Double(self.frame.height)
        
        let myLayer = CAShapeLayer()
        myLayer.frame = rect
        
        let mid = height * 0.5 + median
        let waveLength = width / self.frequency
        
        var ys1 = mid + A * sin(a1) + a3
        var ys2 = mid + B * cos(b1) + b3
        if (Int(time) / speed) % 2 != 0 {
            let yc = ys1
            ys1 = ys2
            ys2 = yc
        }
        let ys = ys1 + (ys2 - ys1) * time.truncatingRemainder(dividingBy: Double(speed)) / Double(speed)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: ys))
        
        for x in stride(from: 0, through: width, by: 1) {
            let actualX = x / waveLength
            var y1 = mid + A * sin(actualX + a1) * cos(actualX / a2) + a3
            var y2 = mid + B * cos(actualX + b1) * cos(actualX / b2) + b3
            
            if (Int(time) / speed) % 2 != 0 {
                let yc = y1
                y1 = y2
                y2 = yc
            }
            
            let y = y1 + (y2 - y1) * time.truncatingRemainder(dividingBy: Double(speed)) / Double(speed)

            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        myLayer.path = path.cgPath
        myLayer.lineWidth = 1
        myLayer.fillColor = UIColor.clear.cgColor
        myLayer.strokeColor = strokeColor.cgColor
        self.layer.addSublayer(myLayer)
    }
}
