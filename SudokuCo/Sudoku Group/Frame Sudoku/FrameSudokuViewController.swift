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
    
    var surroundingNumbersLabels: [[UILabel]] = []
    
    var cellSize = CGFloat(0)
    
    var frameSudokuGame = FrameSudokuGame()
    
    var gamesInfoCoding = GamesInfoCoding(gameName: "Frame Sudoku")
    
    let completeGameView = CompleteGameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gameMode == "Continue" {
            continueGame()
        } else {
            newGame()
        }
        
        configureView()
    }
    
    func newGame() {
        frameSudokuGame.generateSudoku()
        
        if isSaving {
            gamesInfoCoding.encode(game: frameSudokuGame)
        }
    }
    
    func continueGame() {
        frameSudokuGame = gamesInfoCoding.decode() as! FrameSudokuGame
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
        gameElementsStackView.distribution = .equalSpacing
        gameElementsStackView.spacing = 20
        
        gameElementsStackView.translatesAutoresizingMaskIntoConstraints = false
        gameElementsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        gameElementsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        gameElementsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }
    
    func configureSudokuGrid() {
        
        cellSize = (UIScreen.main.bounds.width - 20) / 11
        let gridWidth = cellSize * 9
        
        let framingGridView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20))
        self.gameElementsStackView.addArrangedSubview(framingGridView)
        
        framingGridView.translatesAutoresizingMaskIntoConstraints = false
        framingGridView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        
        
        gridView.formView(width: gridWidth)
        gridView.frame.size = CGSize(width: gridWidth, height: gridWidth)
        gridView.center = framingGridView.center
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.gridView.addGestureRecognizer(gesture)
        
        framingGridView.addSubview(gridView)
        
        configureSurroundingNumbersOfGrid()
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        let touchX = sender.location(in: gridView).x
        let touchY = sender.location(in: gridView).y
        
        gridView.addSubview(selectedCellView)
        gridView.sendSubviewToBack(selectedCellView)
        
        selectedCellView.frame = CGRect(x: floor(touchX/cellSize) * cellSize, y: floor(touchY/cellSize) * cellSize, width: cellSize, height: cellSize)
        selectedCellView.backgroundColor = .lightGray
    }
    
    func configureSurroundingNumbersOfGrid() {
        let sudokuNumbers = frameSudokuGame.getSudokuNumbers()
        surroundingNumbersLabels = [[], [], [], []]
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: -cellSize, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 24)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[0][i] + sudokuNumbers[1][i] + sudokuNumbers[2][i])
            
            surroundingNumbersLabels[0].append(label)
            gridView.addSubview(label)
        }
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: cellSize * 9, y: CGFloat(i) * cellSize, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 24)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[i][6] + sudokuNumbers[i][7] + sudokuNumbers[i][8])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: cellSize * 9, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 24)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[6][i] + sudokuNumbers[7][i] + sudokuNumbers[8][i])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: -cellSize, y: CGFloat(i) * cellSize, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 24)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[i][0] + sudokuNumbers[i][1] + sudokuNumbers[i][2])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
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
    }
    
    @objc func tapNumberPanelButton(sender: UIButton!){
        print("tapNumberPanelButton")
    }
}
