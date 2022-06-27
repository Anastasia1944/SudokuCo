//
//  OddEvenSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 24.06.2022.
//

import UIKit

class OddEvenSudokuViewController: UIViewController {
    
    var gameMode: String = "New Game"
    var isSaving: Bool = true
    
    let gridView = SudokuGridView()
    let sudokuPanelStackView = UIStackView()
    let numberPanelStackView = UIStackView()
    let gameElementsStackView = UIStackView()
    
    let selectedCellView = UIView()
    var filledNumbersView: [[UILabel]] = [[]]
    
    var cellSize = CGFloat(0)
    
    var oddEvenSudokuGame = OddEvenSudokuGame()
    
    var gamesInfoCoding = GamesInfoCoding(gameName: "Odd-Even Sudoku")
    
    let completeGameView = CompleteGameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        if gameMode == "Continue" {
            continueGame()
        } else {
            newGame()
        }
        
        fillCells()
        
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
        navigationController?.popViewController(animated: true)
    }
    
    func startOver() {
        let originallyOpenedNumbers = oddEvenSudokuGame.getSudokuOriginallyOpenedNumbers()
        
        for i in 0...8 {
            for j in 0...8 {
                if originallyOpenedNumbers[i][j] == 0 {
                    _ = oddEvenSudokuGame.fillCell(x: i, y: j, value: 0)
                    filledNumbersView[i][j].text = ""
                    gridView.addSubview(filledNumbersView[i][j])
                }
            }
        }
        
        if isSaving {
            gamesInfoCoding.encode(game: oddEvenSudokuGame)
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
    
    func newGame() {
        oddEvenSudokuGame.generateSudoku()
        
        if isSaving {
            gamesInfoCoding.encode(game: oddEvenSudokuGame)
        }
    }
    
    func continueGame() {
        oddEvenSudokuGame = gamesInfoCoding.decode() as! OddEvenSudokuGame
    }
    
    func fillCells() {
        let openedNumbers = oddEvenSudokuGame.getSudokuOpenedNumbers()
        let originallyOpenedNumbers = oddEvenSudokuGame.getSudokuOriginallyOpenedNumbers()
        
        for i in 0...8 {
            filledNumbersView.append([])
            for j in 0...8 {
                
                if oddEvenSudokuGame.getSudokuNumbers()[i][j] % 2 != 0 {
                    let circle = UIBezierPath(arcCenter: CGPoint(x: CGFloat(i) * cellSize + cellSize / 2, y: CGFloat(j) * cellSize + cellSize / 2), radius: 0.9 * (cellSize / 2), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
                    
                    let shapeLayer = CAShapeLayer()
                    shapeLayer.path = circle.cgPath
                    shapeLayer.strokeColor = UIColor.darkGray.cgColor
                    shapeLayer.fillColor = UIColor.clear.cgColor
                    shapeLayer.lineWidth = 0.2
                    
                    gridView.layer.addSublayer(shapeLayer)
                }
                
                let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: CGFloat(j) * cellSize, width: cellSize, height: cellSize))
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 30)
                if originallyOpenedNumbers[i][j] != 0 {
                    label.text = String(originallyOpenedNumbers[i][j])
                    label.textColor = .gray
                }
                if openedNumbers[i][j] != 0 && originallyOpenedNumbers[i][j] == 0 {
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
        
        let gap = CGFloat(10)
        gridView.setGap(gap)
        gridView.formView()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.gridView.addGestureRecognizer(gesture)
        
        cellSize = gridView.getCellSize()
        
        self.gameElementsStackView.addArrangedSubview(gridView)
        
        gridView.translatesAutoresizingMaskIntoConstraints = false
        gridView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
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
    }
    
    @objc func tapPanelButtonCancel(sender: UIButton!){
        
        if let lastAction = oddEvenSudokuGame.cancelAction() {
            
            selectedCellView.frame = CGRect(x: CGFloat(lastAction.xCell) * cellSize, y: CGFloat(lastAction.yCell) * cellSize, width: cellSize, height: cellSize)
            
            if isSaving {
                gamesInfoCoding.encode(game: oddEvenSudokuGame)
            }
            
            if lastAction.lastNumber != 0 {
                filledNumbersView[lastAction.xCell][lastAction.yCell].text = String(lastAction.lastNumber)
            } else {
                filledNumbersView[lastAction.xCell][lastAction.yCell].text = ""
            }
            gridView.addSubview(filledNumbersView[lastAction.xCell][lastAction.yCell])
        }
    }
    
    @objc func tapPanelButtonDelete(sender: UIButton!){
        
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        if oddEvenSudokuGame.deleteCellNumber(x: cellX, y: cellY) {
            if isSaving {
                gamesInfoCoding.encode(game: oddEvenSudokuGame)
            }
            filledNumbersView[cellX][cellY].text = ""
            gridView.addSubview(filledNumbersView[cellX][cellY])
        }
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!){
        
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        if oddEvenSudokuGame.isNumberOpened(x: cellX, y: cellY) == false {
            let number = oddEvenSudokuGame.fillCellbyRightNumber(x: cellX, y: cellY)
            if isSaving {
                gamesInfoCoding.encode(game: oddEvenSudokuGame)
            }
            filledNumbersView[cellX][cellY].text = String(number)
            gridView.addSubview(filledNumbersView[cellX][cellY])
        }
        
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
        
        if oddEvenSudokuGame.fillCell(x: cellX, y: cellY, value: Int(value)!) {
            if isSaving {
                gamesInfoCoding.encode(game: oddEvenSudokuGame)
            }
            filledNumbersView[cellX][cellY].text = value
            gridView.addSubview(filledNumbersView[cellX][cellY])
        }
        
        ifAllCellsFilledDisplayCompletionView()
    }
    
    func ifAllCellsFilledDisplayCompletionView() {
        if oddEvenSudokuGame.checkIfAllCellsFilled() {
            view.addSubview(completeGameView)
            if oddEvenSudokuGame.checkIfAllCellsRight() {
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
