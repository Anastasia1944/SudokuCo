//
//  GameInfoViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 07.07.2022.
//

import UIKit

class GameInfoViewController: UIViewController {
    
    var gameName: String = ""
    
    private let gameInfos: [String: String] = ["Classic Sudoku": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once.",
                                               "Comparison Sudoku": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once. Also it has comparison signs (“>” and “<”), showing the ratio of numbers in adjacent cells.",
                                               "Dots Sudoku" : "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once. If in neighboring cells one number is twice as large as the other, there is a black dot between them. If the numbers in neighboring cells differ by one, the dot between them is white.",
                                               "Frame Sudoku": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once. This variant of Sudoku contains numbers around the grid instead of the usual task. Each of the numbers represents the sum of the nearest three digits in a row or column.",
                                               "Odd-Even Sudoku": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once. In this variant of Sudoku, information is given about the evenness or oddness of the numbers in the cells. Cells with odd numbers are marked with circles."]
    
    private let gameInfoTextLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .whiteSys
        
        configureTextFieldConstraints()
    }
    
    func configureTextFieldConstraints() {
        
        view.addSubview(gameInfoTextLabel)
        
        gameInfoTextLabel.text = gameInfos[gameName]
        gameInfoTextLabel.numberOfLines = 0
        gameInfoTextLabel.font = .systemFont(ofSize: 26)
        gameInfoTextLabel.textAlignment = .center
        gameInfoTextLabel.adjustsFontForContentSizeCategory = true
        
        gameInfoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        gameInfoTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        gameInfoTextLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        gameInfoTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        gameInfoTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
}
