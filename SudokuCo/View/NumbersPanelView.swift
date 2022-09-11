//
//  NumbersPanelView.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.09.2022.
//

import UIKit

class NumbersPanelView: UIStackView {
    
    func configurePanel(gameController: GeneralSudokuController) {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 2
        
        for i in 1...9 {
            let button = UIButton()
            button.setTitle(String(i), for: .normal)
            button.tag = i
            button.titleLabel?.font = .systemFont(ofSize: 35)
            button.setTitleColor(.blackSys, for: .normal)
            button.setTitleColor(.graySys, for: .selected)
            button.addTarget(gameController, action: #selector(gameController.tapNumberPanelButton), for: .touchUpInside)
            self.addArrangedSubview(button)
        }
    }
}
