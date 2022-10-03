//
//  GameStatisticsTableViewCell.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.07.2022.
//

import UIKit

class GameStatisticsTableViewCell: UITableViewCell {
    
    private let gameStackView = UIStackView()

    private let gameNameLabel = UILabel()
    
    private let statsImgView = UIView()
    private let gamesWonNameLabel = UILabel()
    private let gamesWonLabel = UILabel()
    
    private let averageTimeNameLabel = UILabel()
    private let averageTimeLabel = UILabel()
    
    private let gameImageView = UIImageView()

    private let gamesStatsStackView = UIStackView()
    private let gamesWonStackView = UIStackView()
    private let averageTimeStackView = UIStackView()
    
    private let allGamesLineView = UIView()
    private let winGamesLineView = UIView()
    
    private let percentageView = UILabel()
    
    var gameStatistics: GameStatistics = GameStatistics()
    
    func configureCell() {
        self.backgroundColor = .clear

        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        winGamesLineView.removeFromSuperview()
    }

    private func configureView() {
        contentView.addSubview(gameStackView)
        
        gameStackView.axis = .vertical
        gameStackView.distribution = .equalSpacing
        gameStackView.spacing = 10
        
        gameStackView.translatesAutoresizingMaskIntoConstraints = false
        gameStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        gameStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        gameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        gameStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true

        configureGameNameLabel()
        configureStatsImgView()
        winRateLineSettings()
    }

    private func configureGameNameLabel() {
        gameNameLabel.text = gameStatistics.gameName.rawValue
        gameNameLabel.font = .systemFont(ofSize: 20)
        gameNameLabel.textAlignment = .center
        gameNameLabel.textColor = .lightBlue

        gameStackView.addArrangedSubview(gameNameLabel)
    }

    private func configureStatsImgView() {
        gameStackView.addArrangedSubview(statsImgView)

        configureImageView()
        configureGamesStatsStackView()
    }


    private func configureImageView() {
        gameImageView.image = UIImage(named: gameStatistics.gameName.rawValue)?.withTintColor(.lightBlue)

        statsImgView.addSubview(gameImageView)

        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.topAnchor.constraint(equalTo: statsImgView.topAnchor).isActive = true
        gameImageView.bottomAnchor.constraint(equalTo: statsImgView.bottomAnchor).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: statsImgView.trailingAnchor).isActive = true
        gameImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        gameImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private func configureGamesStatsStackView() {
        gamesStatsStackView.axis = .vertical
        gamesStatsStackView.distribution = .equalSpacing
        gamesStatsStackView.alignment = .center
        gamesStatsStackView.spacing = 10
        gamesStatsStackView.isLayoutMarginsRelativeArrangement = true
        gamesStatsStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        statsImgView.addSubview(gamesStatsStackView)

        gamesStatsStackView.translatesAutoresizingMaskIntoConstraints = false
        gamesStatsStackView.topAnchor.constraint(equalTo: statsImgView.topAnchor).isActive = true
        gamesStatsStackView.leadingAnchor.constraint(equalTo: statsImgView.leadingAnchor).isActive = true
        gamesStatsStackView.trailingAnchor.constraint(equalTo: gameImageView.leadingAnchor).isActive = true
        gamesStatsStackView.bottomAnchor.constraint(equalTo: statsImgView.bottomAnchor).isActive = true

        gamesWonStackViewSettings()
        averageTimeStackViewSettings()
    }

    private func gamesWonStackViewSettings() {
        gamesStatsStackView.addArrangedSubview(gamesWonStackView)

        gamesWonStackView.axis = .horizontal
        gamesWonStackView.distribution = .equalCentering

        gamesWonStackView.translatesAutoresizingMaskIntoConstraints = false
        gamesWonStackView.trailingAnchor.constraint(equalTo: gamesStatsStackView.trailingAnchor, constant: -10).isActive = true
        gamesWonStackView.leadingAnchor.constraint(equalTo: gamesStatsStackView.leadingAnchor, constant: 10).isActive = true

        gamesWonStackView.addArrangedSubview(gamesWonNameLabel)

        gamesWonNameLabel.text = NSLocalizedString("Games Won", comment: "")
        gamesWonNameLabel.font = .systemFont(ofSize: 16)
        gamesWonNameLabel.textColor = .lightBlue

        gamesWonStackView.addArrangedSubview(gamesWonLabel)

        gamesWonLabel.text = String(gameStatistics.winGamesCount)
        gamesWonLabel.font = .systemFont(ofSize: 16)
        gamesWonLabel.textColor = .lightBlue
    }

    private func averageTimeStackViewSettings() {
        gamesStatsStackView.addArrangedSubview(averageTimeStackView)

        averageTimeStackView.axis = .horizontal
        averageTimeStackView.distribution = .equalCentering

        averageTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        averageTimeStackView.trailingAnchor.constraint(equalTo: gamesStatsStackView.trailingAnchor, constant: -10).isActive = true
        averageTimeStackView.leadingAnchor.constraint(equalTo: gamesStatsStackView.leadingAnchor, constant: 10).isActive = true

        averageTimeStackView.addArrangedSubview(averageTimeNameLabel)

        averageTimeNameLabel.text = NSLocalizedString("Average Time", comment: "")
        averageTimeNameLabel.font = .systemFont(ofSize: 16)
        averageTimeNameLabel.textColor = .lightBlue

        averageTimeStackView.addArrangedSubview(averageTimeLabel)

        averageTimeLabel.text = getAverageTime()
        averageTimeLabel.font = .systemFont(ofSize: 16)
        averageTimeLabel.textColor = .lightBlue
    }

    private func winRateLineSettings() {
        allGamesLineView.backgroundColor = .lightBlue.withAlphaComponent(0.3)
        allGamesLineView.layer.cornerRadius = 10
        
        gameStackView.addArrangedSubview(allGamesLineView)
        
        allGamesLineView.translatesAutoresizingMaskIntoConstraints = false
        allGamesLineView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let winRatePercentage = Double(gameStatistics.winGamesCount) / Double(gameStatistics.allgamesCount)
        
        winGamesLineViewSettings(winPersantage: winRatePercentage)
        percentageViewSettings(winPersantage: winRatePercentage)
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

    private func getAverageTime() -> String {
        var time = 0

        for i in 0..<gameStatistics.times.count {
            time += gameStatistics.times[i]
        }

        return intTimeToString(time: time / gameStatistics.allgamesCount)
    }

    private func intTimeToString(time: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: TimeInterval(time))!
    }
}
