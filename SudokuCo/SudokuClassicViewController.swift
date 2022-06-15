//
//  SudokuClassicViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuClassicViewController: UIViewController {
    
    let sudokuPanelStackView = UIStackView()
    var gridView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        let grid = SudokuGrid(deviationY: -100)
        gridView = grid.getView()
        self.view.addSubview(gridView)
        
        configurePanel()
    }
    
    func configurePanel() {
        
        view.addSubview(sudokuPanelStackView)
        
        sudokuPanelStackView.axis = .horizontal
        sudokuPanelStackView.distribution = .fillEqually
        sudokuPanelStackView.spacing = 2
        
        let numberOfButtons = 3
        
        let buttonIcons = ["arrow.counterclockwise", "delete.left", "lightbulb"]
        
        for i in 0...numberOfButtons-1 {
            let button = UIButton()
            button.tintColor = .black
            button.setImage(UIImage(systemName: buttonIcons[i], withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
            sudokuPanelStackView.addArrangedSubview(button)
        }
        
        sudokuPanelStackView.translatesAutoresizingMaskIntoConstraints = false
        sudokuPanelStackView.topAnchor.constraint(equalTo: gridView.bottomAnchor, constant: 600).isActive = true
        sudokuPanelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        sudokuPanelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        sudokuPanelStackView.heightAnchor.constraint(equalToConstant: CGFloat(100)).isActive = true
    }
}
