//
//  GameBaseButton.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 04.10.2022.
//

import UIKit

class GameBaseButton: UIButton {
    func configureButton(buttonText: String) {
        self.setBackgroundColor(color: .beige, forState: .normal)
        self.setBackgroundColor(color: .lightBlue, forState: .highlighted)
        self.layer.cornerRadius = 20
        self.setTitle(NSLocalizedString(buttonText, comment: ""), for: .normal)
        self.setTitleColor(.lightBlue, for: .normal)
        self.setTitleColor(.beige, for: .highlighted)
        self.titleLabel?.font = .systemFont(ofSize: 26)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightBlue.cgColor

        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 240).isActive = true
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
