//
//  FrameSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 29.06.2022.
//

import UIKit

class FrameSudokuViewController: UIViewController {
    
    var gameMode: String = "New Game"
    var isSaving: Bool = true
    
    let gridView = SudokuGridView()
    let sudokuPanelStackView = UIStackView()
    let numberPanelStackView = UIStackView()
    let gameElementsStackView = UIStackView()
    
    let selectedCellView = UIView()
    var filledNumbersView: [[UILabel]] = [[]]
    
    var cellSize = CGFloat(0)
    
    var classicSudokuGame = FrameSudokuGame()
    
    var gamesInfoCoding = GamesInfoCoding(gameName: "Frame Sudoku")
    
    let completeGameView = CompleteGameView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        configureGameElementsStack()
        configureSudokuGrid()
        configurePanel()
        configureNumberPanel()
    }
    
    func configureGameElementsStack() {
        view.addSubview(gameElementsStackView)
        
        gameElementsStackView.axis = .vertical
        gameElementsStackView.distribution = .fillProportionally
        gameElementsStackView.alignment = .center
        gameElementsStackView.spacing = 20
        
        gameElementsStackView.translatesAutoresizingMaskIntoConstraints = false
        gameElementsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        gameElementsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        gameElementsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }
    
    func configureSudokuGrid() {
        
        let gap = CGFloat(40)
        gridView.setGap(gap)
        gridView.formView()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.gridView.addGestureRecognizer(gesture)
        
        cellSize = gridView.getCellSize()
        
        self.gameElementsStackView.addArrangedSubview(gridView)
        
        gridView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2 * gap).isActive = true
        gridView.widthAnchor.constraint(equalToConstant:UIScreen.main.bounds.width - 2 * gap).isActive = true
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        let touchX = sender.location(in: gridView).x
        let touchY = sender.location(in: gridView).y
        
        gridView.addSubview(selectedCellView)
        gridView.sendSubviewToBack(selectedCellView)
        
        selectedCellView.frame = CGRect(x: floor(touchX/cellSize) * cellSize, y: floor(touchY/cellSize) * cellSize, width: cellSize, height: cellSize)
        selectedCellView.backgroundColor = .lightGray
    }
    
    func configurePanel() {
        self.gameElementsStackView.addArrangedSubview(sudokuPanelStackView)
        
        sudokuPanelStackView.axis = .horizontal
        sudokuPanelStackView.distribution = .fillEqually
        sudokuPanelStackView.spacing = 2
        
        let numberOfButtons = 3
        
        let buttonIcons = ["arrow.counterclockwise", "delete.left", "lightbulb"]
        
        for i in 0...numberOfButtons-1 {
            let button = UIButton()
            button.tintColor = .black
            button.setImage(UIImage(systemName: buttonIcons[i], withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
            switch buttonIcons[i] {
            case "arrow.counterclockwise": button.addTarget(self, action: #selector(tapPanelButtonCancel), for: .touchUpInside)
            case "delete.left": button.addTarget(self, action: #selector(tapPanelButtonDelete), for: .touchUpInside)
            case "lightbulb": button.addTarget(self, action: #selector(tapPanelButtonTip), for: .touchUpInside)
            default:
                return
            }
            sudokuPanelStackView.addArrangedSubview(button)
        }
        
        sudokuPanelStackView.leadingAnchor.constraint(equalTo: gameElementsStackView.leadingAnchor).isActive = true
    }
    
    @objc func tapPanelButtonCancel(sender: UIButton!) {
        print("tapPanelButtonCancel")
    }
    
    @objc func tapPanelButtonDelete(sender: UIButton!) {
        print("tapPanelButtonDelete")
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!) {
        print("tapPanelButtonTip")
    }
    
    func configureNumberPanel() {
        self.gameElementsStackView.addArrangedSubview(numberPanelStackView)
        
        numberPanelStackView.axis = .horizontal
        numberPanelStackView.distribution = .fillEqually
        numberPanelStackView.spacing = 2
        
        for i in 1...9 {
            let button = UIButton()
            button.setTitle(String(i), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 35)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(tapNumberPanelButton), for: .touchUpInside)
            numberPanelStackView.addArrangedSubview(button)
        }
        
        numberPanelStackView.leadingAnchor.constraint(equalTo: gameElementsStackView.leadingAnchor).isActive = true
    }
    
    @objc func tapNumberPanelButton(sender: UIButton!){
        print("tapNumberPanelButton")
    }
}
