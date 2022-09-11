//
//  LettersPanelView.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.09.2022.
//

import UIKit

class LettersPanelView: UIStackView {
    
    func configurePanel(gameController: GeneralSudokuController, lettersRange: ClosedRange<Int>) {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 2
        
        for i in lettersRange {
            let button = UIButton()
            button.setTitle(String(UnicodeScalar(i + 64)!), for: .normal)
            button.tag = i
            button.titleLabel?.font = .systemFont(ofSize: 35)
            button.setTitleColor(.blackSys, for: .normal)
            button.setTitleColor(.graySys, for: .selected)
            button.addTarget(gameController, action: #selector(gameController.tapNumberPanelButton), for: .touchUpInside)
            self.addArrangedSubview(button)
        }
    }
}

