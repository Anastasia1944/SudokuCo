//
//  CompleteViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 07.07.2022.
//

import UIKit

class CompleteViewController: UIViewController {
    
    let winLoseLabel = UILabel()
    let statisticView = UIView()
    
    let mainMenuButton = UIButton()
    let startOverButton = UIButton()
    
    var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        stackSettings()
        
        winLoseLabelSettings()
        statisticViewSettings()
        
        mainMenuButtonSettings()
        startOverButtonSettings()
    }
    
    func stackSettings() {
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 30
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    func winLoseLabelSettings() {
        stackView.addArrangedSubview(winLoseLabel)
        
        winLoseLabel.text = "You Win!"
        winLoseLabel.textAlignment = .center
        winLoseLabel.font = .systemFont(ofSize: 32)
        winLoseLabel.textColor = .blueSys
        
        winLoseLabel.translatesAutoresizingMaskIntoConstraints = false
        winLoseLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        winLoseLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
    }
    
    func statisticViewSettings() {
        stackView.addArrangedSubview(statisticView)
        
        statisticView.backgroundColor = .graySys
        statisticView.layer.cornerRadius = 30
        
        statisticView.translatesAutoresizingMaskIntoConstraints = false
        statisticView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        statisticView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
        statisticView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func mainMenuButtonSettings() {
        stackView.addArrangedSubview(mainMenuButton)
        
        mainMenuButton.backgroundColor = .blueSys
        mainMenuButton.layer.cornerRadius = 10
        mainMenuButton.setTitle("Main Menu", for: .normal)
        mainMenuButton.setTitleColor(.whiteSys, for: .normal)
        mainMenuButton.titleLabel?.font = .systemFont(ofSize: 26)
        
        mainMenuButton.translatesAutoresizingMaskIntoConstraints = false
        mainMenuButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        mainMenuButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func startOverButtonSettings() {
        stackView.addArrangedSubview(startOverButton)
        
        startOverButton.backgroundColor = .blueSys
        startOverButton.layer.cornerRadius = 10
        startOverButton.setTitle("Start Over", for: .normal)
        startOverButton.setTitleColor(.whiteSys, for: .normal)
        startOverButton.titleLabel?.font = .systemFont(ofSize: 26)
        
        startOverButton.translatesAutoresizingMaskIntoConstraints = false
        startOverButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        startOverButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
