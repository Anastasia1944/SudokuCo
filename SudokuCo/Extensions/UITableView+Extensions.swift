//
//  UITableView+Extensions.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 08.09.2022.
//

import UIKit

extension UITableView {
    func setEmptyView(mainText: String, addText: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .darkBlue
        titleLabel.font = .systemFont(ofSize: 24)
        messageLabel.textColor = .darkBlue
        messageLabel.font = .systemFont(ofSize: 20)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        titleLabel.text = mainText
        messageLabel.text = addText
        
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
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
        self.backgroundView = emptyView
    }
}
