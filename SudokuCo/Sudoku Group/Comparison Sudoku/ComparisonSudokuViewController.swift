//
//  ComparisonSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 30.06.2022.
//

import UIKit

class ComparisonSudokuViewController: UIViewController {
    
    var gameMode: String = "New Game"
    var isSaving: Bool = true
    
    let gridView = SudokuGridView()
    let sudokuPanelStackView = UIStackView()
    let numberPanelStackView = UIStackView()
    let gameElementsStackView = UIStackView()
    
    let selectedCellView = UIView()
    var filledNumbersView: [[UILabel]] = []
    
    var cellSize = CGFloat(0)
    
    var comparisonSudokuGame = ComparisonSudokuGame()
    
    var gamesInfoCoding = GamesInfoCoding(gameName: "Comparison Sudoku")
    
    let completeGameView = CompleteGameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gameMode == "Continue" {
            continueGame()
        } else {
            newGame()
        }
        
        configureView()
        
        configureGridLabels()
        
        configureCompleteGameView()
        
        completeGameView.userAnswer = { buttonAnswer in
            switch buttonAnswer {
            case "Main Menu": self.quitToMainMenu()
            case "Start Over": self.startOver()
            case "Continue": self.continueGameAfterLose()
            default: return
            }
        }
        
        ifAllCellsFilledDisplayCompletionView()
    }
    
    func newGame() {
        comparisonSudokuGame.generateSudoku()
        
        if isSaving {
            gamesInfoCoding.encode(game: comparisonSudokuGame)
        }
    }
    
    func continueGame() {
        comparisonSudokuGame = gamesInfoCoding.decode() as! ComparisonSudokuGame
    }
    
    func configureCompleteGameView() {
        completeGameView.translatesAutoresizingMaskIntoConstraints = false
        completeGameView.backgroundColor = UIColor.graySys.withAlphaComponent(0.9)
        
        completeGameView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        completeGameView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    func quitToMainMenu() {
        
        if isSaving {
            gamesInfoCoding.deleteGameInfo()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func startOver() {
        
        for i in 0...8 {
            for j in 0...8 {
                
                comparisonSudokuGame.fillCell(x: i, y: j, value: 0)
                filledNumbersView[i][j].text = ""
                gridView.addSubview(filledNumbersView[i][j])
                
            }
        }
        
        if isSaving {
            gamesInfoCoding.encode(game: comparisonSudokuGame)
        }
        
        completeGameView.removeFromSuperview()
    }
    
    func continueGameAfterLose() {
        completeGameView.removeFromSuperview()
    }
    
    func configureGridLabels() {
        let openedNumbers = comparisonSudokuGame.getSudokuOpenedNumbers()
        
        for i in 0...8 {
            filledNumbersView.append([])
            for j in 0...8 {
                let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: CGFloat(j) * cellSize, width: cellSize, height: cellSize))
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 30)
                
                if openedNumbers[i][j] != 0 {
                    label.text = String(openedNumbers[i][j])
                    label.textColor = .black
                }
                filledNumbersView[i].append(label)
                gridView.addSubview(filledNumbersView[i][j])
            }
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        configureGameElementsStack()
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
        
        configureSudokuGrid()
        configurePanel()
        configureNumberPanel()
    }
    
    func configureSudokuGrid() {
        
        cellSize = (UIScreen.main.bounds.width - 20) / 9
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
        
        configureMoreLessSigns()
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        let touchX = sender.location(in: gridView).x
        let touchY = sender.location(in: gridView).y
        
        gridView.addSubview(selectedCellView)
        gridView.sendSubviewToBack(selectedCellView)
        
        selectedCellView.frame = CGRect(x: floor(touchX/cellSize) * cellSize, y: floor(touchY/cellSize) * cellSize, width: cellSize, height: cellSize)
        selectedCellView.backgroundColor = .lightGray
    }
    
    func configureMoreLessSigns() {
        
        let sudokuNumbers = comparisonSudokuGame.getSudokuNumbers()
        
        for i in 0...8 {
            for j in 0..<8 {
                if (j + 1) % 3 != 0 {
                    for k in 1...2 {
                        var a = sudokuNumbers[i][j]
                        var b = sudokuNumbers[i][j + 1]
                        
                        var signCenter = CGPoint(x: CGFloat(i) * cellSize + cellSize / 2, y: (CGFloat(j) + 1) * cellSize)
                        
                        let signView = MoreLessSignView()
                        signView.configureSign(cellSize: cellSize)
                        
                        if k == 2 {
                            a = sudokuNumbers[j][i]
                            b = sudokuNumbers[j + 1][i]
                            signCenter = CGPoint(x: (CGFloat(j) + 1) * cellSize, y: CGFloat(i) * cellSize + cellSize / 2)
                            signView.transform = signView.transform.rotated(by: .pi * 1.5)
                        }
                        
                        if a > b {
                            signView.transform = signView.transform.rotated(by: .pi)
                        }
                        
                        signView.center = gridView.convert(signCenter, to: gridView)
                        gridView.addSubview(signView)
                    }
                }
            }
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
        if let lastAction = comparisonSudokuGame.cancelAction() {
            
            selectedCellView.frame = CGRect(x: CGFloat(lastAction.xCell) * cellSize, y: CGFloat(lastAction.yCell) * cellSize, width: cellSize, height: cellSize)
            
            if isSaving {
                gamesInfoCoding.encode(game: comparisonSudokuGame)
            }
            
            if lastAction.lastNumber != 0 {
                filledNumbersView[lastAction.xCell][lastAction.yCell].text = String(lastAction.lastNumber)
            } else {
                filledNumbersView[lastAction.xCell][lastAction.yCell].text = ""
            }
            gridView.addSubview(filledNumbersView[lastAction.xCell][lastAction.yCell])
        }
    }
    
    @objc func tapPanelButtonDelete(sender: UIButton!) {
        
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        comparisonSudokuGame.deleteCellNumber(x: cellX, y: cellY)
        
        if isSaving {
            gamesInfoCoding.encode(game: comparisonSudokuGame)
        }
        filledNumbersView[cellX][cellY].text = ""
        gridView.addSubview(filledNumbersView[cellX][cellY])
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!) {
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        let number = comparisonSudokuGame.fillCellbyRightNumber(x: cellX, y: cellY)
        if isSaving {
            gamesInfoCoding.encode(game: comparisonSudokuGame)
        }
        filledNumbersView[cellX][cellY].text = String(number)
        gridView.addSubview(filledNumbersView[cellX][cellY])
        
        ifAllCellsFilledDisplayCompletionView()
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
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        let value = sender.titleLabel!.text!
        
        comparisonSudokuGame.fillCell(x: cellX, y: cellY, value: Int(value)!)
        if isSaving {
            gamesInfoCoding.encode(game: comparisonSudokuGame)
        }
        filledNumbersView[cellX][cellY].text = value
        gridView.addSubview(filledNumbersView[cellX][cellY])
        
        
        ifAllCellsFilledDisplayCompletionView()
    }
    
    func ifAllCellsFilledDisplayCompletionView() {
        if comparisonSudokuGame.checkIfAllCellsFilled() {
            view.addSubview(completeGameView)
            if comparisonSudokuGame.checkIfAllCellsRight() {
                completeGameView.configureView(isWinning: true)
            } else {
                completeGameView.configureView(isWinning: false)
            }
        }
    }
    
    func getCellsByCoordinates() -> (x: Int, y: Int) {
        let x = Int(floor(selectedCellView.frame.midX / cellSize))
        let y = Int(floor(selectedCellView.frame.midY / cellSize))
        return (x, y)
    }
}