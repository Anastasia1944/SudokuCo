//
//  GamesListTableViewCell.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 27.09.2022.
//

import UIKit

class GamesListTableViewCell: UITableViewCell {
    
    let cellStack = UIStackView()
    
    let gameIconStackLeft = UIStackView()
    let gameButtonLeft = UIButton()
    let gameNameLabelLeft = UILabel()
    
    let gameIconStackRight = UIStackView()
    let gameButtonRight = UIButton()
    let gameNameLabelRight = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        cellStackSettings()
    }
    
    func cellStackSettings() {
        contentView.addSubview(cellStack)
        
        cellStack.axis = .horizontal
        cellStack.distribution = .fillEqually
        cellStack.alignment = .center
        cellStack.spacing = 20
        
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        cellStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        cellStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        cellStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        cellStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        addLeftGameSettings()
        addRightGameSettings()
    }
    
    func addLeftGameSettings() {
        cellStack.addArrangedSubview(gameIconStackLeft)
        
        gameIconStackLeft.axis = .vertical
        gameIconStackLeft.distribution = .equalSpacing
        gameIconStackLeft.alignment = .center
        gameIconStackLeft.spacing = 10
        
        gameButtonSettingsLeft()
        gameNameLabelSettingsLeft()
    }
    
    func gameButtonSettingsLeft() {
        gameIconStackLeft.addArrangedSubview(gameButtonLeft)
        
        gameButtonLeft.tintColor = .lightBlue

        gameButtonLeft.translatesAutoresizingMaskIntoConstraints = false
        gameButtonLeft.heightAnchor.constraint(equalToConstant: 100).isActive = true
        gameButtonLeft.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    func gameNameLabelSettingsLeft() {
        gameIconStackLeft.addArrangedSubview(gameNameLabelLeft)

        gameNameLabelLeft.font = UIFont.systemFont(ofSize: 20)
        gameNameLabelLeft.textAlignment = .center
        gameNameLabelLeft.textColor = .lightBlue
    }
    
    func addRightGameSettings() {
        cellStack.addArrangedSubview(gameIconStackRight)
        
        gameIconStackRight.axis = .vertical
        gameIconStackRight.distribution = .equalSpacing
        gameIconStackRight.alignment = .center
        gameIconStackRight.spacing = 10
        
        gameButtonSettingsRight()
        gameNameLabelSettingsRight()
    }
    
    func gameButtonSettingsRight() {
        gameIconStackRight.addArrangedSubview(gameButtonRight)
        
        gameButtonRight.tintColor = .lightBlue

        gameButtonRight.translatesAutoresizingMaskIntoConstraints = false
        gameButtonRight.heightAnchor.constraint(equalToConstant: 100).isActive = true
        gameButtonRight.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    func gameNameLabelSettingsRight() {
        gameIconStackRight.addArrangedSubview(gameNameLabelRight)

        gameNameLabelRight.font = UIFont.systemFont(ofSize: 20)
        gameNameLabelRight.textAlignment = .center
        gameNameLabelRight.textColor = .lightBlue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
