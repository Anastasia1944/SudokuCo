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
    private let gameNameLabel = UILabel()
    
    private let gameStatsStackView = UIStackView()
    
    private let allGamesLineView = UIView()
    private let winGamesLineView = UIView()
    private let percentageView = UILabel()

    private let mainMenuButton = GameBaseButton()
    private let startOverButton = GameBaseButton()
    private let continueButton = GameBaseButton()
    
    private var completeController = CompleteGameController()
    
    var startOver: ((Bool) -> Void)?
    var continueGame: ((Bool) -> Void)?

    private var gameName: GamesNames = .classicSudoku
    private var gameLevel: DifficultyLevels = .easy
    private var isWin: Bool = true
    private var isSaving: Bool = true
    private var time: Int = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureCompleteVC(isWin: Bool, time: Int, gameName: GamesNames, isSaving: Bool, level: DifficultyLevels) {
        self.gameName = gameName
        self.gameLevel = level
        self.isWin = isWin
        self.isSaving = isSaving
        self.time = time
        
        completeController.addNewElementStatistic(gameName: gameName, gameLevel: level, time: time, isWin: isWin, isSaving: isSaving)
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .beige
        configureConfettiIfWin()
        
        view.addSubview(stackView)
        view.setBackgroundWaves(waves: 5, color: .lightBlue.withAlphaComponent(0.5))
        
        stackSettings()
    }
    
    private func configureConfettiIfWin() {
        if !isWin {
            return
        }
        
        let layer = CAEmitterLayer()
        layer.emitterPosition = CGPoint(x: view.center.x, y: -10)
        
        let colors: [UIColor] = [.darkBlue,
                                 .lightBlue,
                                 .lightPink,
                                 .lightGray,
                                 .lightPink]
        
        let cells: [CAEmitterCell] = colors.compactMap {
            let cell = CAEmitterCell()
            cell.scale = 0.03
            cell.emissionRange = .pi * 2
            cell.lifetime = 10
            cell.birthRate = 10
            cell.velocity = 50
            cell.color = $0.cgColor
            cell.contents = UIImage(named: "Confetti")?.cgImage
            return cell
        }
        
        layer.emitterCells = cells
        
        view.layer.addSublayer(layer)
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
        
        winLoseLabelSettings()
        gameNameLabelSettings()
        gameStatsStacksSettings()
        winRateLineSettings()
        
        mainMenuButtonSettings()
        startOverButtonSettings()
        if !isWin {
            continueButtonSettings()
        }
    }
    
    func winLoseLabelSettings() {
        stackView.addArrangedSubview(winLoseLabel)
        
        if isWin {
            winLoseLabel.text = "You Win!"
        } else {
            winLoseLabel.text = "You Lose"
        }
        
        winLoseLabel.textAlignment = .center
        winLoseLabel.font = .systemFont(ofSize: 32)
        winLoseLabel.textColor = .lightBlue
        
        winLoseLabel.translatesAutoresizingMaskIntoConstraints = false
        winLoseLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        winLoseLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
    }
    
    func gameNameLabelSettings() {
        stackView.addArrangedSubview(gameNameLabel)
        
        gameNameLabel.text = gameName.rawValue
        
        gameNameLabel.textAlignment = .center
        gameNameLabel.font = .systemFont(ofSize: 20)
        gameNameLabel.textColor = .lightBlue
        
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameNameLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        gameNameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
    }
    
    func gameStatsStacksSettings() {
        stackView.addArrangedSubview(gameStatsStackView)
        
        gameStatsStackView.axis = .vertical
        gameStatsStackView.distribution = .equalSpacing
        gameStatsStackView.alignment = .center
        gameStatsStackView.spacing = 15
        
        gameStatsStackView.translatesAutoresizingMaskIntoConstraints = false
        gameStatsStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        gameStatsStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
        
        let stats: [(String, String)] = [("Level", gameLevel.rawValue),
                                         ("Games Played", String(completeController.getAllGamesCount())),
                                         ("Current Time", completeController.getCurrentTimeString()),
                                         ("Average Time", completeController.getAverageTimeString())]

        for stat in stats {
            addStatRow(leftString: stat.0, rightString: stat.1)
        }
    }
    
    func addStatRow(leftString: String, rightString: String) {
        let statStackView = UIStackView()
        
        gameStatsStackView.addArrangedSubview(statStackView)

        statStackView.axis = .horizontal
        statStackView.distribution = .equalCentering

        statStackView.translatesAutoresizingMaskIntoConstraints = false
        statStackView.trailingAnchor.constraint(equalTo: gameStatsStackView.trailingAnchor, constant: -10).isActive = true
        statStackView.leadingAnchor.constraint(equalTo: gameStatsStackView.leadingAnchor, constant: 10).isActive = true

        let leftLabel = UILabel()

        statStackView.addArrangedSubview(leftLabel)

        leftLabel.text = leftString
        leftLabel.font = .systemFont(ofSize: 24)
        leftLabel.textColor = .lightBlue

        let rightLabel = UILabel()

        statStackView.addArrangedSubview(rightLabel)

        rightLabel.text = rightString
        rightLabel.font = .systemFont(ofSize: 24)
        rightLabel.textColor = .lightBlue
    }
    
    private func winRateLineSettings() {
        allGamesLineView.backgroundColor = .lightBlue.withAlphaComponent(0.3)
        allGamesLineView.layer.cornerRadius = 10
        
        stackView.addArrangedSubview(allGamesLineView)
        
        allGamesLineView.translatesAutoresizingMaskIntoConstraints = false
        allGamesLineView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        allGamesLineView.trailingAnchor.constraint(equalTo: gameStatsStackView.trailingAnchor).isActive = true
        allGamesLineView.leadingAnchor.constraint(equalTo: gameStatsStackView.leadingAnchor).isActive = true
        
        let winRatePercentage = Double(completeController.getWinGamesCount()) / Double(completeController.getAllGamesCount())
        
        winGamesLineViewSettings(winPersantage: winRatePercentage)
    }
    
    private func winGamesLineViewSettings(winPersantage: Double) {
        winGamesLineView.backgroundColor = .lightBlue
        winGamesLineView.layer.cornerRadius = 10

        allGamesLineView.addSubview(winGamesLineView)

        winGamesLineView.translatesAutoresizingMaskIntoConstraints = false
        winGamesLineView.topAnchor.constraint(equalTo: allGamesLineView.topAnchor).isActive = true
        winGamesLineView.widthAnchor.constraint(equalTo: allGamesLineView.widthAnchor, multiplier: winPersantage).isActive = true
        winGamesLineView.bottomAnchor.constraint(equalTo: allGamesLineView.bottomAnchor).isActive = true
        winGamesLineView.leadingAnchor.constraint(equalTo: allGamesLineView.leadingAnchor).isActive = true
        
        percentageViewSettings(winPersantage: winPersantage)
    }

    private func percentageViewSettings(winPersantage: Double) {
        percentageView.textAlignment = .left

        percentageView.text = String(round(winPersantage * 1000) / 10) + "%"
        percentageView.textColor = .beige

        winGamesLineView.addSubview(percentageView)

        percentageView.translatesAutoresizingMaskIntoConstraints = false
        percentageView.topAnchor.constraint(equalTo: winGamesLineView.topAnchor).isActive = true
        percentageView.bottomAnchor.constraint(equalTo: winGamesLineView.bottomAnchor).isActive = true
        percentageView.leadingAnchor.constraint(equalTo: winGamesLineView.leadingAnchor, constant: 10).isActive = true
    }
    
    func mainMenuButtonSettings() {
        stackView.addArrangedSubview(mainMenuButton)
        
        mainMenuButton.configureButton(buttonText: "Main Menu")
        mainMenuButton.addTarget(self, action: #selector(tapMainMenuButton), for: .touchUpInside)
    }

    @objc func tapMainMenuButton() {
        let gameInfoCoding = GamesInfoCoding()
        gameInfoCoding.deleteGameInfo(gameName: gameName)

        navigationController?.popToRootViewController(animated: true)
    }

    func startOverButtonSettings() {
        stackView.addArrangedSubview(startOverButton)
        
        startOverButton.configureButton(buttonText: "Start Over")
        startOverButton.addTarget(self, action: #selector(tapStartOverButton), for: .touchUpInside)
    }

    @objc func tapStartOverButton() {
        self.startOver!(true)
        navigationController?.popViewController(animated: true)
    }

    func continueButtonSettings() {
        stackView.addArrangedSubview(continueButton)
        
        continueButton.configureButton(buttonText: "Continue")
        continueButton.addTarget(self, action: #selector(tapContinueButton), for: .touchUpInside)
    }

    @objc func tapContinueButton() {
        self.continueGame!(true)
        navigationController?.popViewController(animated: true)
    }
}
