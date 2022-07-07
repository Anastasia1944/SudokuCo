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
    private let statisticStackView = UIStackView()
    
    private let statisticsLabel = UILabel()
    private let timeStackView = UIStackView()
    private let gamesWonStackView = UIStackView()
    private let winRateStackView = UIStackView()
    private let averageTimeStackView = UIStackView()
    
    private let mainMenuButton = UIButton()
    private let startOverButton = UIButton()

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
    
    func configureCompleteVC(time: String) {
        print(time)
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
        stackView.addArrangedSubview(statisticStackView)
        
        statisticStackView.axis = .vertical
        statisticStackView.distribution = .equalSpacing
        statisticStackView.alignment = .center
        statisticStackView.spacing = 20
        statisticStackView.isLayoutMarginsRelativeArrangement = true
        statisticStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 20)
        
        statisticStackView.backgroundColor = .graySys
        statisticStackView.layer.cornerRadius = 30
        
        statisticStackView.translatesAutoresizingMaskIntoConstraints = false
        statisticStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
        statisticStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
        
        statisticLabelSettings()
        timeStackViewSettings()
        gamesWonStackViewSettings()
        winRateStackViewSettings()
        averageTimeStackViewSettings()
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
        
        timeLabel.text = "9:20"
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
        
        gamesWonLabel.text = "3"
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
        
        winRateLabel.text = "37.8%"
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
        
        averageTimeLabel.text = "15:10"
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
