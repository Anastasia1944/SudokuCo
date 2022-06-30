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
    var filledNumbersView: [[UILabel]] = []
    
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
    
    func quitToMainMenu() {
        
        if isSaving {
            gamesInfoCoding.deleteGameInfo()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func startOver() {
        
        for i in 0...8 {
            for j in 0...8 {

                frameSudokuGame.fillCell(x: i, y: j, value: 0)
                    filledNumbersView[i][j].text = ""
                    gridView.addSubview(filledNumbersView[i][j])

            }
        }
        
        if isSaving {
            gamesInfoCoding.encode(game: frameSudokuGame)
        }
        
        completeGameView.removeFromSuperview()
    }
    
    func continueGameAfterLose() {
        completeGameView.removeFromSuperview()
    }
    
    func configureCompleteGameView() {
        completeGameView.translatesAutoresizingMaskIntoConstraints = false
        completeGameView.backgroundColor = UIColor.graySys.withAlphaComponent(0.9)
        
        completeGameView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        completeGameView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    func configureGridLabels() {
        let openedNumbers = frameSudokuGame.getSudokuOpenedNumbers()
        
        for i in 0...8 {
            filledNumbersView.append([])
            for j in 0...8 {
                let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: CGFloat(j) * cellSize, width: cellSize, height: cellSize))
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 24)
                
                if openedNumbers[i][j] != 0 {
                    label.text = String(openedNumbers[i][j])
                    label.textColor = .black
                }
                filledNumbersView[i].append(label)
                gridView.addSubview(filledNumbersView[i][j])
            }
        }
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
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[i][0] + sudokuNumbers[i][1] + sudokuNumbers[i][2])
            
            surroundingNumbersLabels[0].append(label)
            gridView.addSubview(label)
        }
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: cellSize * 9, y: CGFloat(i) * cellSize, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[6][i] + sudokuNumbers[7][i] + sudokuNumbers[8][i])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: cellSize * 9, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[i][6] + sudokuNumbers[i][7] + sudokuNumbers[i][8])
            
            surroundingNumbersLabels[1].append(label)
            gridView.addSubview(label)
        }
        
        for i in 0...8 {
            let label = UILabel(frame: CGRect(x: -cellSize, y: CGFloat(i) * cellSize, width: cellSize, height: cellSize))
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.textColor = .blackSys
            label.text = String(sudokuNumbers[0][i] + sudokuNumbers[1][i] + sudokuNumbers[2][i])
            
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
        if let lastAction = frameSudokuGame.cancelAction() {
            
            selectedCellView.frame = CGRect(x: CGFloat(lastAction.xCell) * cellSize, y: CGFloat(lastAction.yCell) * cellSize, width: cellSize, height: cellSize)
            
            if isSaving {
                gamesInfoCoding.encode(game: frameSudokuGame)
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
        
        frameSudokuGame.deleteCellNumber(x: cellX, y: cellY)
        
            if isSaving {
                gamesInfoCoding.encode(game: frameSudokuGame)
            }
            filledNumbersView[cellX][cellY].text = ""
            gridView.addSubview(filledNumbersView[cellX][cellY])
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!) {
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
            let number = frameSudokuGame.fillCellbyRightNumber(x: cellX, y: cellY)
            if isSaving {
                gamesInfoCoding.encode(game: frameSudokuGame)
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
        
        frameSudokuGame.fillCell(x: cellX, y: cellY, value: Int(value)!)
            if isSaving {
                gamesInfoCoding.encode(game: frameSudokuGame)
            }
            filledNumbersView[cellX][cellY].text = value
            gridView.addSubview(filledNumbersView[cellX][cellY])
        
        
        ifAllCellsFilledDisplayCompletionView()
    }
    
    func ifAllCellsFilledDisplayCompletionView() {
        if frameSudokuGame.checkIfAllCellsFilled() {
            view.addSubview(completeGameView)
            if frameSudokuGame.checkIfAllCellsRight() {
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