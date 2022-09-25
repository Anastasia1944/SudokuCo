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
    
    let myGamesButton = UIButton()
    let gamesLibraryButton = UIButton()
    let statisticsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .beige
        
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
        let infoButtonImg = UIImage(systemName: "info.circle")
        let infoButton = UIBarButtonItem(image: infoButtonImg, style: .plain, target: self, action: #selector(infoItemTapped))
        infoButton.tintColor = .lightBlue
        
        let settingsButtonImg = UIImage(systemName: "gearshape")
        let settingsButton = UIBarButtonItem(image: settingsButtonImg, style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = .lightBlue
        
        navigationItem.rightBarButtonItems = [infoButton, settingsButton]
    }
    
    @objc func infoItemTapped() {
        let alert = UIAlertController(title: NSLocalizedString("App Info", comment: ""), message: NSLocalizedString("Feedback", comment: ""), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Write", comment: ""), style: .default, handler: { _ in
            let email = "sudokuCoGame@outlook.com"
            if let url = URL(string: "mailto:\(email)") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
        
        myGamesButton.setBackgroundColor(color: .beige, forState: .normal)
        myGamesButton.setBackgroundColor(color: .lightBlue, forState: .highlighted)
        myGamesButton.layer.cornerRadius = 20
        myGamesButton.setTitle(NSLocalizedString("My Games", comment: ""), for: .normal)
        myGamesButton.setTitleColor(.lightBlue, for: .normal)
        myGamesButton.setTitleColor(.beige, for: .highlighted)
        myGamesButton.titleLabel?.font = .systemFont(ofSize: 26)
        myGamesButton.layer.borderWidth = 2
        myGamesButton.layer.borderColor = UIColor.lightBlue.cgColor
        myGamesButton.tag = 0
        myGamesButton.addTarget(self, action: #selector(transitionToVC), for: .touchUpInside)
        
        myGamesButton.translatesAutoresizingMaskIntoConstraints = false
        myGamesButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        myGamesButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func gameLibraryButtonSettings() {
        buttonsStackView.addArrangedSubview(gamesLibraryButton)
        
        gamesLibraryButton.setBackgroundColor(color: .beige, forState: .normal)
        gamesLibraryButton.setBackgroundColor(color: .lightBlue, forState: .highlighted)
        gamesLibraryButton.layer.cornerRadius = 20
        gamesLibraryButton.setTitle(NSLocalizedString("Game Library", comment: ""), for: .normal)
        gamesLibraryButton.setTitleColor(.lightBlue, for: .normal)
        gamesLibraryButton.setTitleColor(.beige, for: .highlighted)
        gamesLibraryButton.titleLabel?.font = .systemFont(ofSize: 26)
        gamesLibraryButton.layer.borderWidth = 2
        gamesLibraryButton.layer.borderColor = UIColor.lightBlue.cgColor
        gamesLibraryButton.tag = 1
        gamesLibraryButton.addTarget(self, action: #selector(transitionToVC), for: .touchUpInside)
        
        gamesLibraryButton.translatesAutoresizingMaskIntoConstraints = false
        gamesLibraryButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        gamesLibraryButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func statisticsButtonSettings() {
        buttonsStackView.addArrangedSubview(statisticsButton)
        
        statisticsButton.setBackgroundColor(color: .beige, forState: .normal)
        statisticsButton.setBackgroundColor(color: .lightBlue, forState: .highlighted)
        statisticsButton.layer.cornerRadius = 20
        statisticsButton.setTitle(NSLocalizedString("Statistics", comment: ""), for: .normal)
        statisticsButton.setTitleColor(.lightBlue, for: .normal)
        statisticsButton.setTitleColor(.beige, for: .highlighted)
        statisticsButton.titleLabel?.font = .systemFont(ofSize: 26)
        statisticsButton.layer.borderWidth = 2
        statisticsButton.layer.borderColor = UIColor.lightBlue.cgColor
        statisticsButton.tag = 2
        statisticsButton.addTarget(self, action: #selector(transitionToVC), for: .touchUpInside)
        
        statisticsButton.translatesAutoresizingMaskIntoConstraints = false
        statisticsButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        statisticsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
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
