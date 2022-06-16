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
    let numberPanelStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        configureSudokuGrid()
        configurePanel()
        configureNumberPanel()
    }
    
    func configureSudokuGrid() {
        let gap = CGFloat(10)
        let grid = SudokuGrid(gap: gap)
        gridView = grid.getView()
        self.view.addSubview(gridView)
        
        gridView.translatesAutoresizingMaskIntoConstraints = false
        gridView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -gap).isActive = true
        gridView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: gap).isActive = true
        gridView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -(UIScreen.main.bounds.width - 20) / 2).isActive = true
        gridView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
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
        sudokuPanelStackView.topAnchor.constraint(equalTo: gridView.bottomAnchor, constant: 30).isActive = true
        sudokuPanelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        sudokuPanelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        sudokuPanelStackView.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
    }
    
    func configureNumberPanel() {
        view.addSubview(numberPanelStackView)
        
        numberPanelStackView.axis = .horizontal
        numberPanelStackView.distribution = .fillEqually
        numberPanelStackView.spacing = 2
        
        for i in 1...9 {
            let button = UIButton()
            button.setTitle(String(i), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 35)
            button.setTitleColor(.black, for: .normal)
            numberPanelStackView.addArrangedSubview(button)
        }
        
        numberPanelStackView.translatesAutoresizingMaskIntoConstraints = false
        numberPanelStackView.topAnchor.constraint(equalTo: sudokuPanelStackView.bottomAnchor, constant: 30).isActive = true
        numberPanelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        numberPanelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        numberPanelStackView.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
    }
}
