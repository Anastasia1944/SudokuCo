//
//  File.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.09.2022.
//

import UIKit

class GamePanelElementsView: UIStackView {
    func configurePanel(gameController: GeneralSudokuController) {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 2
        
        for i in gameController.gameSettings.whichNumsSaved {
            let button = UIButton()
            if gameController.gameSettings.fillElements == .letters {
                button.setTitle(String(UnicodeScalar(i + 64)!), for: .normal)
            } else {
                button.setTitle(String(i), for: .normal)
            }
            button.tag = i
            button.titleLabel?.font = .systemFont(ofSize: 35)
            button.setTitleColor(.lightBlue, for: .normal)
            button.setTitleColor(.lightGray, for: .selected)
            button.addTarget(gameController, action: #selector(gameController.tapNumberPanelButton), for: .touchUpInside)
            self.addArrangedSubview(button)
        }
        
        if gameController.gameSettings.whichNumsSaved != Constants.sudokuNumbersRange {
            let button = UIButton()
            button.setTitle("-", for: .normal)
            button.tag = -1
            button.titleLabel?.font = .systemFont(ofSize: 35)
            button.setTitleColor(.lightBlue, for: .normal)
            button.addTarget(gameController, action: #selector(gameController.tapNumberPanelButton), for: .touchUpInside)
            self.addArrangedSubview(button)
        }
    }
}
