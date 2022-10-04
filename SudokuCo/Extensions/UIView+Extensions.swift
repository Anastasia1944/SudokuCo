//
//  UIView+Extensions.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 04.10.2022.
//

import UIKit

extension UIView {
    func setBackgroundWaves(waves: Int, color: UIColor = .darkBlue) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        for _ in 1...waves {
            let wave = WaveView()
            emptyView.addSubview(wave)
            
            wave.transform = wave.transform.rotated(by: .pi * Double.random(in: -0.2...0.2))
            wave.strokeColor = color
            
            wave.translatesAutoresizingMaskIntoConstraints = false
            wave.heightAnchor.constraint(equalToConstant: 400).isActive = true
            wave.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor).isActive = true
            wave.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: -100).isActive = true
            wave.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: 100).isActive = true
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                wave.animationStart()
            }
        }
        self.addSubview(emptyView)
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
