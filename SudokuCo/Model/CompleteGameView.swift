//
//  CompleteGameView.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 25.06.2022.
//

import UIKit

class CompleteGameView: UIView {
    
    var userAnswer: ( (String) -> Void )?
    
    var elementsStackView = UIStackView()
    
    var textLabel: UILabel = {
        var textLabel = UILabel()
        textLabel.text = "Win/Lose"
        textLabel.tintColor = .blueSys
        textLabel.font = .systemFont(ofSize: 32)
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    var mainMenuButton: UIButton = {
        var mainMenuButton = UIButton()
        mainMenuButton.backgroundColor = .blueSys
        mainMenuButton.setTitle("Main Menu", for: .normal)
        mainMenuButton.setTitleColor(.whiteSys, for: .normal)
        mainMenuButton.layer.cornerRadius = 5
        mainMenuButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        mainMenuButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        mainMenuButton.addTarget(self, action: #selector(tapButtonMainMenu), for: .touchUpInside)
        return mainMenuButton
    }()
    
    var startOverButton: UIButton = {
        var startOverButton = UIButton()
        startOverButton.backgroundColor = .blueSys
        startOverButton.setTitle("Start Over", for: .normal)
        startOverButton.setTitleColor(.whiteSys, for: .normal)
        startOverButton.layer.cornerRadius = 5
        startOverButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        startOverButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        startOverButton.addTarget(self, action: #selector(tapButtonStartOver), for: .touchUpInside)
        return startOverButton
    }()
    
    var continueButton: UIButton = {
        var continueButton = UIButton()
        continueButton.backgroundColor = .blueSys
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.whiteSys, for: .normal)
        continueButton.layer.cornerRadius = 5
        continueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        continueButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        continueButton.addTarget(self, action: #selector(tapButtonContinue), for: .touchUpInside)
        return continueButton
    }()
    
    func configureView(isWinning: Bool) {
        
        self.addSubview(elementsStackView)
        elementsStackView.addArrangedSubview(textLabel)
        
        elementsStackView.axis = .vertical
        elementsStackView.distribution = .fill
        elementsStackView.alignment = .fill
        elementsStackView.spacing = 40
        
        elementsStackView.translatesAutoresizingMaskIntoConstraints = false
        elementsStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        elementsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        if isWinning {
            configureWinView()
        } else {
            configureLoseView()
        }
    }
    
    func configureWinView() {
        continueButton.removeFromSuperview()
        textLabel.text = "You Win!"
        elementsStackView.addArrangedSubview(mainMenuButton)
        elementsStackView.addArrangedSubview(startOverButton)
    }
    
    func configureLoseView() {
        textLabel.text = "You Lose"
        elementsStackView.addArrangedSubview(mainMenuButton)
        elementsStackView.addArrangedSubview(startOverButton)
        elementsStackView.addArrangedSubview(continueButton)
    }
    
    @objc func tapButtonMainMenu() {
        self.userAnswer!("Main Menu")
    }
    
    @objc func tapButtonStartOver() {
        self.userAnswer!("Start Over")
    }
    
    @objc func tapButtonContinue() {
        self.userAnswer!("Continue")
    }
}

