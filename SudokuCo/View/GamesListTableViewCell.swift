//
//  GamesListTableViewCell.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 27.09.2022.
//

import UIKit

class GamesListTableViewCell: UITableViewCell {
    
    let cellStack = UIStackView()
    
    var rowStacks: [UIStackView] = []
    var buttonsLabels: [(UIButton, UILabel)] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        cellStackSettings()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rowStacks.forEach {
            $0.removeFromSuperview()
        }
        
        buttonsLabels = []
        rowStacks = []
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
    }
    
    func addGames() {
        for (button, label) in buttonsLabels {
            let stackView = UIStackView()
            rowStacks.append(stackView)
            
            cellStack.addArrangedSubview(stackView)
            
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.alignment = .center
            stackView.spacing = 10
            
            stackView.addArrangedSubview(button)
            buttonSettings(button: button)
            
            stackView.addArrangedSubview(label)
            labelSettings(label: label)
        }
    }
    
    func buttonSettings(button: UIButton) {
        button.tintColor = .lightBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func labelSettings(label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .lightBlue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
