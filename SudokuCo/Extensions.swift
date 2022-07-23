//
//  Extensions.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 24.06.2022.
//

import UIKit


extension UIColor {
    static let blackSys: UIColor = UIColor(named: "blackSys")!
    static let blueSys: UIColor = UIColor(named: "blueSys")!
    static let graySys: UIColor = UIColor(named: "graySys")!
    static let orangeSys: UIColor = UIColor(named: "orangeSys")!
    static let whiteSys: UIColor = UIColor(named: "whiteSys")!
}

extension UITableView {
    func setEmptyView(mainText: String, addText: String) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .graySys
        titleLabel.font = .systemFont(ofSize: 24)
        messageLabel.textColor = .graySys
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
}
