//
//  GameInfoViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 07.07.2022.
//

import UIKit

class GameInfoViewController: UIViewController {
    
    var gameName: GamesNames = .classicSudoku
    
    private let gameInfoTextLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .beige
        
        navBarSettings()
        configureTextFieldConstraints()
    }
    
    func navBarSettings() {
        let backButton = UIBarButtonItem()
        backButton.title = gameName.rawValue
        backButton.tintColor = .lightBlue
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func configureTextFieldConstraints() {
        view.addSubview(gameInfoTextLabel)
        
        gameInfoTextLabel.text = GameInfos().getInfoByGameName(gameName)
        gameInfoTextLabel.numberOfLines = 0
        gameInfoTextLabel.font = .systemFont(ofSize: 20)
        gameInfoTextLabel.textColor = .lightBlue
        gameInfoTextLabel.textAlignment = .center
        gameInfoTextLabel.adjustsFontForContentSizeCategory = true

        gameInfoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        gameInfoTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        gameInfoTextLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        gameInfoTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        gameInfoTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
}
