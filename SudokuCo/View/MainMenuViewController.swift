//
//  MainMenuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 24.09.2022.
//

import UIKit

class MainMenuViewController: UIViewController {

    let mainStackView = UIStackView()
    let buttonsStackView = UIStackView()
    
    let sudokuCoLabel = UILabel()
    
    let myGamesButton = GameBaseButton()
    let gamesLibraryButton = GameBaseButton()
    let statisticsButton = GameBaseButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .beige
        
        navigationController?.navigationBar.barTintColor = .beige
        
        addNavButtons()
        
        addBackgroundWaves()
        
        view.addSubview(mainStackView)
        mainStackSettings()
        
        gameNameLabelSettings()
        
        buttonsStackViewSettings()
        myGamesButtonSettings()
        gameLibraryButtonSettings()
        statisticsButtonSettings()
    }
    
    func addNavButtons() {
        let settingsButtonImg = UIImage(systemName: "gear")
        let settingsButton = UIBarButtonItem(image: settingsButtonImg, style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = .lightBlue
        
        navigationItem.rightBarButtonItems = [settingsButton]
    }
    
    @objc func settingsButtonTapped() {
        let settingsVC = SettingsViewController()
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func addBackgroundWaves() {
        for _ in 0...5 {
            let wave = WaveView()
            view.addSubview(wave)
            
            wave.transform = wave.transform.rotated(by: .pi * Double.random(in: -0.2...0.2))
            
            wave.translatesAutoresizingMaskIntoConstraints = false
            wave.heightAnchor.constraint(equalToConstant: 400).isActive = true
            wave.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            wave.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -100).isActive = true
            wave.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 100).isActive = true
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                wave.animationStart()
            }
        }
    }
    
    func mainStackSettings() {
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.spacing = 100
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    func gameNameLabelSettings() {
        mainStackView.addArrangedSubview(sudokuCoLabel)
        
        sudokuCoLabel.text = "SudokuCo"
        sudokuCoLabel.textAlignment = .center
        sudokuCoLabel.font = .systemFont(ofSize: 50)
        sudokuCoLabel.textColor = .lightBlue
        
        sudokuCoLabel.translatesAutoresizingMaskIntoConstraints = false
        sudokuCoLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -20).isActive = true
        sudokuCoLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20).isActive = true
    }
    
    func buttonsStackViewSettings() {
        mainStackView.addArrangedSubview(buttonsStackView)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 20
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func myGamesButtonSettings() {
        buttonsStackView.addArrangedSubview(myGamesButton)
        
        myGamesButton.configureButton(buttonText: "My Games")
        myGamesButton.tag = 0
        myGamesButton.addTarget(self, action: #selector(transitionToVC), for: .touchUpInside)
    }
    
    func gameLibraryButtonSettings() {
        buttonsStackView.addArrangedSubview(gamesLibraryButton)
        
        gamesLibraryButton.configureButton(buttonText: "Game Library")
        gamesLibraryButton.tag = 1
        gamesLibraryButton.addTarget(self, action: #selector(transitionToVC), for: .touchUpInside)
    }
    
    func statisticsButtonSettings() {
        buttonsStackView.addArrangedSubview(statisticsButton)
        
        statisticsButton.configureButton(buttonText: "Statistics")
        statisticsButton.tag = 2
        statisticsButton.addTarget(self, action: #selector(transitionToVC), for: .touchUpInside)
    }
    
    @objc func transitionToVC(sender: UIButton) {
        switch sender.tag {
        case 0:
            let myGamesVC = MyGamesViewController()
            navigationController?.pushViewController(myGamesVC, animated: true)
        case 1:
            let gameLibraryVC = GameLibraryViewController()
            navigationController?.pushViewController(gameLibraryVC, animated: true)
        case 2:
            let statisticsVC = GamesStatisticsViewController()
            navigationController?.pushViewController(statisticsVC, animated: true)
        default:
            print("No VC")
        }
    }

}
