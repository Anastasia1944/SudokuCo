//
//  CompleteViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 07.07.2022.
//

import UIKit

class CompleteViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    private let winLoseLabel = UILabel()
    private let gameLevelLabel = UILabel()
    private let statisticStackView = UIStackView()
    
    private let statisticsLabel = UILabel()
    private let timeStackView = UIStackView()
    private let gamesWonStackView = UIStackView()
    private let winRateStackView = UIStackView()
    private let averageTimeStackView = UIStackView()
    
    private let mainMenuButton = UIButton()
    private let startOverButton = UIButton()
    private let continueButton = UIButton()
    
    private var completeController = CompleteGameController()
    
    var startOver: ( (Bool) -> Void )?
    var continueGame: ( (Bool) -> Void )?
    
    var gameName: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureCompleteVC(isWin: Bool, time: Int, gameName: String, isSaving: Bool, level: DifficultyLevels) {
        self.gameName = gameName
        
        completeController.configureStats(gameName: gameName, level: level)
        completeController.addNewElementStatistic(gameName: gameName, gameLevel: level ,time: time, isWin: isWin, isSaving: isSaving)
        
        let gameLevelString = DifficultyLevelsStringToEnum().getDifficultyLevelStringByEnum(level: level)
        
        configureView(isWin: isWin, isSaving: isSaving, gameLevel: gameLevelString)
    }
    
    func configureView(isWin: Bool, isSaving: Bool, gameLevel: String) {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        stackSettings()
        
        winLoseLabelSettings(isWin: isWin)
        gameLevelLabelSettings(gameLevel: gameLevel)
        statisticViewSettings(isSaving: isSaving)
        
        mainMenuButtonSettings()
        startOverButtonSettings()
        
        if !isWin {
            continueButtonSettings()
        }
    }
    
    func stackSettings() {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    func winLoseLabelSettings(isWin: Bool) {
        stackView.addArrangedSubview(winLoseLabel)
        
        if isWin {
            winLoseLabel.text = "You Win!"
        } else {
            winLoseLabel.text = "You Lose"
        }
        
        winLoseLabel.textAlignment = .center
        winLoseLabel.font = .systemFont(ofSize: 32)
        winLoseLabel.textColor = .blueSys
        
        winLoseLabel.translatesAutoresizingMaskIntoConstraints = false
        winLoseLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        winLoseLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
    }
    
    func gameLevelLabelSettings(gameLevel: String) {
        stackView.addArrangedSubview(gameLevelLabel)
        
        gameLevelLabel.text = "Level: \(gameLevel)"
        
        gameLevelLabel.textAlignment = .center
        gameLevelLabel.font = .systemFont(ofSize: 20)
        gameLevelLabel.textColor = .blueSys
        
        gameLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        gameLevelLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        gameLevelLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
    }
    
    func statisticViewSettings(isSaving: Bool) {
        stackView.addArrangedSubview(statisticStackView)
        
        statisticStackView.axis = .vertical
        statisticStackView.distribution = .equalSpacing
        statisticStackView.alignment = .center
        statisticStackView.spacing = 20
        statisticStackView.isLayoutMarginsRelativeArrangement = true
        statisticStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0)
        
        statisticStackView.backgroundColor = .graySys
        statisticStackView.layer.cornerRadius = 30
        
        statisticStackView.translatesAutoresizingMaskIntoConstraints = false
        statisticStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        statisticStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
        
        statisticLabelSettings()
        timeStackViewSettings()
        if isSaving {
            gamesWonStackViewSettings()
            winRateStackViewSettings()
            averageTimeStackViewSettings()
        }
    }
    
    func statisticLabelSettings() {
        statisticStackView.addArrangedSubview(statisticsLabel)
        
        statisticsLabel.text = "Statistics:"
        statisticsLabel.textAlignment = .center
        statisticsLabel.font = .systemFont(ofSize: 24)
        statisticsLabel.textColor = .blueSys
        
        statisticsLabel.translatesAutoresizingMaskIntoConstraints = false
        statisticsLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        statisticsLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
    }
    
    func timeStackViewSettings() {
        statisticStackView.addArrangedSubview(timeStackView)
        
        timeStackView.axis = .horizontal
        timeStackView.distribution = .equalCentering
        
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.trailingAnchor.constraint(equalTo: statisticStackView.trailingAnchor, constant: -10).isActive = true
        timeStackView.leadingAnchor.constraint(equalTo: statisticStackView.leadingAnchor, constant: 10).isActive = true
        
        let timeNameLabel = UILabel()
        
        timeStackView.addArrangedSubview(timeNameLabel)
        
        timeNameLabel.text = "Time"
        timeNameLabel.font = .systemFont(ofSize: 24)
        timeNameLabel.textColor = .blueSys
        
        let timeLabel = UILabel()
        
        timeStackView.addArrangedSubview(timeLabel)
        
        timeLabel.text = completeController.getCurrentTimeString()
        timeLabel.font = .systemFont(ofSize: 24)
        timeLabel.textColor = .blueSys
    }
    
    func gamesWonStackViewSettings() {
        statisticStackView.addArrangedSubview(gamesWonStackView)
        
        gamesWonStackView.axis = .horizontal
        gamesWonStackView.distribution = .equalCentering
        
        gamesWonStackView.translatesAutoresizingMaskIntoConstraints = false
        gamesWonStackView.trailingAnchor.constraint(equalTo: statisticStackView.trailingAnchor, constant: -10).isActive = true
        gamesWonStackView.leadingAnchor.constraint(equalTo: statisticStackView.leadingAnchor, constant: 10).isActive = true
        
        let gamesWonNameLabel = UILabel()
        
        gamesWonStackView.addArrangedSubview(gamesWonNameLabel)
        
        gamesWonNameLabel.text = "Games Won"
        gamesWonNameLabel.font = .systemFont(ofSize: 24)
        gamesWonNameLabel.textColor = .blueSys
        
        let gamesWonLabel = UILabel()
        
        gamesWonStackView.addArrangedSubview(gamesWonLabel)
        
        gamesWonLabel.text = String(completeController.getWinGamesCount())
        gamesWonLabel.font = .systemFont(ofSize: 24)
        gamesWonLabel.textColor = .blueSys
    }
    
    func winRateStackViewSettings() {
        statisticStackView.addArrangedSubview(winRateStackView)
        
        winRateStackView.axis = .horizontal
        winRateStackView.distribution = .equalCentering
        
        winRateStackView.translatesAutoresizingMaskIntoConstraints = false
        winRateStackView.trailingAnchor.constraint(equalTo: statisticStackView.trailingAnchor, constant: -10).isActive = true
        winRateStackView.leadingAnchor.constraint(equalTo: statisticStackView.leadingAnchor, constant: 10).isActive = true
        
        let winRateNameLabel = UILabel()
        
        winRateStackView.addArrangedSubview(winRateNameLabel)
        
        winRateNameLabel.text = "Win rate"
        winRateNameLabel.font = .systemFont(ofSize: 24)
        winRateNameLabel.textColor = .blueSys
        
        let winRateLabel = UILabel()
        
        winRateStackView.addArrangedSubview(winRateLabel)
        
        winRateLabel.text = completeController.getWinRatePercentage()
        winRateLabel.font = .systemFont(ofSize: 24)
        winRateLabel.textColor = .blueSys
    }
    
    func averageTimeStackViewSettings() {
        statisticStackView.addArrangedSubview(averageTimeStackView)
        
        averageTimeStackView.axis = .horizontal
        averageTimeStackView.distribution = .equalCentering
        
        averageTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        averageTimeStackView.trailingAnchor.constraint(equalTo: statisticStackView.trailingAnchor, constant: -10).isActive = true
        averageTimeStackView.leadingAnchor.constraint(equalTo: statisticStackView.leadingAnchor, constant: 10).isActive = true
        
        let averageTimeNameLabel = UILabel()
        
        averageTimeStackView.addArrangedSubview(averageTimeNameLabel)
        
        averageTimeNameLabel.text = "Average Time"
        averageTimeNameLabel.font = .systemFont(ofSize: 24)
        averageTimeNameLabel.textColor = .blueSys
        
        let averageTimeLabel = UILabel()
        
        averageTimeStackView.addArrangedSubview(averageTimeLabel)
        
        averageTimeLabel.text = completeController.getAverageTimeString()
        averageTimeLabel.font = .systemFont(ofSize: 24)
        averageTimeLabel.textColor = .blueSys
    }
    
    func mainMenuButtonSettings() {
        stackView.addArrangedSubview(mainMenuButton)
        
        mainMenuButton.backgroundColor = .blueSys
        mainMenuButton.layer.cornerRadius = 10
        mainMenuButton.setTitle("Main Menu", for: .normal)
        mainMenuButton.setTitleColor(.whiteSys, for: .normal)
        mainMenuButton.titleLabel?.font = .systemFont(ofSize: 26)
        mainMenuButton.addTarget(self, action: #selector(tapMainMenuButton), for: .touchUpInside)
        
        mainMenuButton.translatesAutoresizingMaskIntoConstraints = false
        mainMenuButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        mainMenuButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func tapMainMenuButton() {
        let gameInfoCoding = GamesInfoCoding()
//        gameInfoCoding.configureInfoForSaving(gameName: gameName)
        gameInfoCoding.deleteGameInfo(gameName: gameName)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    func startOverButtonSettings() {
        stackView.addArrangedSubview(startOverButton)
        
        startOverButton.backgroundColor = .blueSys
        startOverButton.layer.cornerRadius = 10
        startOverButton.setTitle("Restart Game", for: .normal)
        startOverButton.setTitleColor(.whiteSys, for: .normal)
        startOverButton.titleLabel?.font = .systemFont(ofSize: 26)
        startOverButton.addTarget(self, action: #selector(tapStartOverButton), for: .touchUpInside)
        
        startOverButton.translatesAutoresizingMaskIntoConstraints = false
        startOverButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        startOverButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func tapStartOverButton() {
        self.startOver!(true)
        
        navigationController?.popViewController(animated: true)
    }
    
    func continueButtonSettings() {
        stackView.addArrangedSubview(continueButton)
        
        continueButton.backgroundColor = .blueSys
        continueButton.layer.cornerRadius = 10
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.whiteSys, for: .normal)
        continueButton.titleLabel?.font = .systemFont(ofSize: 26)
        continueButton.addTarget(self, action: #selector(tapContinueButton), for: .touchUpInside)
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func tapContinueButton() {
        self.continueGame!(true)
        
        navigationController?.popViewController(animated: true)
    }
}
