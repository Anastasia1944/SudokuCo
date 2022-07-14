//
//  GameStatisticsTableViewCell.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.07.2022.
//

import UIKit

class GameStatisticsTableViewCell: UITableViewCell {
    
    private let viewCell = UIView()
    
    private let gameNameLabel = UILabel()
    private let gameImageView = UIImageView()
    
    private let gamesStatsStackView = UIStackView()
    private let gamesWonStackView = UIStackView()
    private let winRateStackView = UIStackView()
    private let averageTimeStackView = UIStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        
        configureView()
    }
    
    private func configureView() {
        viewCell.backgroundColor = .graySys
        viewCell.layer.cornerRadius = 30
        
        contentView.addSubview(viewCell)
        
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        viewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        viewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        viewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        viewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        
        configureGameNameLabel()
        configureImageView()
        configureGamesStatsStackView()
    }
    
    private func configureGameNameLabel() {
        gameNameLabel.text = "Game Name"
        gameNameLabel.font = .systemFont(ofSize: 20)
        gameNameLabel.textAlignment = .center
        
        viewCell.addSubview(gameNameLabel)
        
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameNameLabel.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: 10).isActive = true
        gameNameLabel.centerXAnchor.constraint(equalTo: viewCell.centerXAnchor).isActive = true
    }
    
    private func configureImageView() {
        gameImageView.image = UIImage(named: "Classic Sudoku")
        
        viewCell.addSubview(gameImageView)
        
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 10).isActive = true
        gameImageView.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -10).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: -10).isActive = true
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
        
        viewCell.addSubview(gamesStatsStackView)
        
        gamesStatsStackView.translatesAutoresizingMaskIntoConstraints = false
        gamesStatsStackView.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 10).isActive = true
        gamesStatsStackView.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 10).isActive = true
        gamesStatsStackView.trailingAnchor.constraint(equalTo: gameImageView.leadingAnchor, constant: -10).isActive = true
        gamesStatsStackView.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -10).isActive = true
        
        gamesWonStackViewSettings()
        winRateStackViewSettings()
        averageTimeStackViewSettings()
    }
    
    private func gamesWonStackViewSettings() {
        gamesStatsStackView.addArrangedSubview(gamesWonStackView)
        
        gamesWonStackView.axis = .horizontal
        gamesWonStackView.distribution = .equalCentering
        
        gamesWonStackView.translatesAutoresizingMaskIntoConstraints = false
        gamesWonStackView.trailingAnchor.constraint(equalTo: gamesStatsStackView.trailingAnchor, constant: -10).isActive = true
        gamesWonStackView.leadingAnchor.constraint(equalTo: gamesStatsStackView.leadingAnchor, constant: 10).isActive = true
        
        let gamesWonNameLabel = UILabel()
        
        gamesWonStackView.addArrangedSubview(gamesWonNameLabel)
        
        gamesWonNameLabel.text = "Games Won"
        gamesWonNameLabel.font = .systemFont(ofSize: 16)
        gamesWonNameLabel.textColor = .blueSys
        
        let gamesWonLabel = UILabel()
        
        gamesWonStackView.addArrangedSubview(gamesWonLabel)
        
        gamesWonLabel.text = "3"
        gamesWonLabel.font = .systemFont(ofSize: 16)
        gamesWonLabel.textColor = .blueSys
    }
    
    func winRateStackViewSettings() {
        gamesStatsStackView.addArrangedSubview(winRateStackView)
        
        winRateStackView.axis = .horizontal
        winRateStackView.distribution = .equalCentering
        
        winRateStackView.translatesAutoresizingMaskIntoConstraints = false
        winRateStackView.trailingAnchor.constraint(equalTo: gamesStatsStackView.trailingAnchor, constant: -10).isActive = true
        winRateStackView.leadingAnchor.constraint(equalTo: gamesStatsStackView.leadingAnchor, constant: 10).isActive = true
        
        let winRateNameLabel = UILabel()
        
        winRateStackView.addArrangedSubview(winRateNameLabel)
        
        winRateNameLabel.text = "Win rate"
        winRateNameLabel.font = .systemFont(ofSize: 16)
        winRateNameLabel.textColor = .blueSys
        
        let winRateLabel = UILabel()
        
        winRateStackView.addArrangedSubview(winRateLabel)
        
        winRateLabel.text = "32%"
        winRateLabel.font = .systemFont(ofSize: 16)
        winRateLabel.textColor = .blueSys
    }
    
    func averageTimeStackViewSettings() {
        gamesStatsStackView.addArrangedSubview(averageTimeStackView)
        
        averageTimeStackView.axis = .horizontal
        averageTimeStackView.distribution = .equalCentering
        
        averageTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        averageTimeStackView.trailingAnchor.constraint(equalTo: gamesStatsStackView.trailingAnchor, constant: -10).isActive = true
        averageTimeStackView.leadingAnchor.constraint(equalTo: gamesStatsStackView.leadingAnchor, constant: 10).isActive = true
        
        let averageTimeNameLabel = UILabel()
        
        averageTimeStackView.addArrangedSubview(averageTimeNameLabel)
        
        averageTimeNameLabel.text = "Average Time"
        averageTimeNameLabel.font = .systemFont(ofSize: 16)
        averageTimeNameLabel.textColor = .blueSys
        
        let averageTimeLabel = UILabel()
        
        averageTimeStackView.addArrangedSubview(averageTimeLabel)
        
        averageTimeLabel.text = "10:20"
        averageTimeLabel.font = .systemFont(ofSize: 16)
        averageTimeLabel.textColor = .blueSys
    }
}
