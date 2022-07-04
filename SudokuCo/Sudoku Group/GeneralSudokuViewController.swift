//
//  GeneralSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 02.07.2022.
//

import UIKit

class GeneralSudokuViewController: UIViewController {
    
    var gameMode: String = "New Game"
    var isSaving: Bool = true
    var cellSize = CGFloat(0)
    var openedNum = CGFloat(0)
    
    let gridView = SudokuGridView()
    let sudokuPanelStackView = UIStackView()
    let numberPanelStackView = UIStackView()
    let gameElementsStackView = UIStackView()
    
    let selectedCellView = UIView()
    var filledNumbersView: [[UILabel]] = []
    let completeGameView = CompleteGameView()
    var numbersButtons: [UIButton] = []
    var notesLabels: [[[UILabel]]] = []
    
    var generalSudokuGame = GeneralSudokuGame()
    var gamesInfoCoding = GamesInfoCoding()
    
    func configureInit(gridWidth: CGFloat = UIScreen.main.bounds.width - 20) {
        cellSize = gridWidth / 9
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gameMode == "Continue" {
            continueGame()
        } else {
            newGame()
        }
        
        configureView()
        configureGridLabels()
        configureNotesLabels()
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
        generalSudokuGame.generateSudoku(openedNum: Int(openedNum))
        
        saveInfo()
    }
    
    func continueGame() {
        generalSudokuGame = gamesInfoCoding.decode() as! GeneralSudokuGame
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
        
        let buttonIcons = ["arrow.counterclockwise", "delete.left", "square.and.pencil", "lightbulb"]
        
        for i in 0..<buttonIcons.count {
            let button = UIButton()
            button.tintColor = .black
            button.setImage(UIImage(systemName: buttonIcons[i], withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
            switch buttonIcons[i] {
            case "arrow.counterclockwise": button.addTarget(self, action: #selector(tapPanelButtonCancel), for: .touchUpInside)
            case "delete.left": button.addTarget(self, action: #selector(tapPanelButtonDelete), for: .touchUpInside)
            case "square.and.pencil": button.addTarget(self, action: #selector(tapPanelButtonNote), for: .touchUpInside)
            case "lightbulb": button.addTarget(self, action: #selector(tapPanelButtonTip), for: .touchUpInside)
            default:
                return
            }
            sudokuPanelStackView.addArrangedSubview(button)
        }
    }
    
    @objc func tapPanelButtonCancel(sender: UIButton!) {
        if let lastAction = generalSudokuGame.cancelAction() {
            
            selectedCellView.frame = CGRect(x: CGFloat(lastAction.xCell) * cellSize, y: CGFloat(lastAction.yCell) * cellSize, width: cellSize, height: cellSize)
            
            saveInfo()
            
            if lastAction.note {
                if lastAction.isAddNote {
                    notesLabels[lastAction.xCell][lastAction.yCell][lastAction.lastNumber - 1].text = String(lastAction.lastNumber)
                } else {
                    notesLabels[lastAction.xCell][lastAction.yCell][lastAction.lastNumber - 1].text = ""
                }

            } else {
                if lastAction.lastNumber != 0 {
                    filledNumbersView[lastAction.xCell][lastAction.yCell].text = String(lastAction.lastNumber)
                } else {
                    filledNumbersView[lastAction.xCell][lastAction.yCell].text = ""
                }
            }
        }
    }
    
    @objc func tapPanelButtonDelete(sender: UIButton!) {
        
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        clearCellNotes(x: cellX, y: cellY)
        clearCellFromMainNumber(x: cellX, y: cellY)
    }
    
    @objc func tapPanelButtonNote(sender: UIButton!) {
        if !numbersButtons[0].isSelected {
            for i in 0...8 {
                numbersButtons[i].isSelected = true
            }
        } else {
            for i in 0...8 {
                numbersButtons[i].isSelected = false
            }
        }
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!) {
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        if !generalSudokuGame.isNumberOriginallyOpened(x: cellX, y: cellY) {
            let number = generalSudokuGame.fillCellbyRightNumber(x: cellX, y: cellY)
            
            saveInfo()
            
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
            button.setTitleColor(.graySys, for: .selected)
            button.addTarget(self, action: #selector(tapNumberPanelButton), for: .touchUpInside)
            numbersButtons.append(button)
            numberPanelStackView.addArrangedSubview(button)
        }
    }
    
    @objc func tapNumberPanelButton(sender: UIButton!){
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        let value = sender.titleLabel!.text!
        
        if numbersButtons[0].isSelected {
            
            if filledNumbersView[cellX][cellY].text != nil {
                clearCellFromMainNumber(x: cellX, y: cellY)
            }
            
            if generalSudokuGame.fillCellByNote(x: cellX, y: cellY, value: Int(value)!) {
                if notesLabels[cellX][cellY][Int(value)! - 1].text == String(value) {
                    notesLabels[cellX][cellY][Int(value)! - 1].text = ""
                } else {
                    notesLabels[cellX][cellY][Int(value)! - 1].text = String(value)
                }
                gridView.addSubview(notesLabels[cellX][cellY][Int(value)! - 1])
            }
        } else {
            
            clearCellNotes(x: cellX, y: cellY)
            
            if generalSudokuGame.fillCell(x: cellX, y: cellY, value: Int(value)!) {
                saveInfo()
                
                filledNumbersView[cellX][cellY].text = value
                gridView.addSubview(filledNumbersView[cellX][cellY])
            }
        }
        
        ifAllCellsFilledDisplayCompletionView()
    }
    
    func configureGridLabels() {
        let openedNumbers = generalSudokuGame.getSudokuOpenedNumbers()
        let originallyOpenedNumbers = generalSudokuGame.getSudokuOriginallyOpenedNumbers()

        for i in 0...8 {
            filledNumbersView.append([])
            for j in 0...8 {
                let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: CGFloat(j) * cellSize, width: cellSize, height: cellSize))
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 28)
                
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
    
    func configureNotesLabels() {
        let notesNumbers = generalSudokuGame.getSudokuNotesNumbers()
        
        for i in 0...8 {
            notesLabels.append([])
            for j in 0...8 {
                notesLabels[i].append([])
                for k in 0...8 {
                    
                    let xSize = CGFloat(i) * cellSize + CGFloat(k % 3) * cellSize / 3
                    let ySize = CGFloat(j) * cellSize + CGFloat(k / 3) * cellSize / 3
                    
                    let label = UILabel(frame: CGRect(x: xSize, y: ySize, width: cellSize / 3, height: cellSize / 3))
                    label.textAlignment = .center
                    label.font = .systemFont(ofSize: 10)
                    
                    if notesNumbers[i][j][k + 1]! {
                        label.text = String(k + 1)
                        label.textColor = .gray
                    }
                    
                    notesLabels[i][j].append(label)
                    gridView.addSubview(notesLabels[i][j][k])
                }
            }
        }
    }
    
    func configureCompleteGameView() {
        completeGameView.translatesAutoresizingMaskIntoConstraints = false
        completeGameView.backgroundColor = UIColor.graySys.withAlphaComponent(0.9)
        
        completeGameView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        completeGameView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    func quitToMainMenu() {
        saveInfo()
        
        navigationController?.popViewController(animated: true)
    }
    
    func startOver() {
        let originallyOpenedNumbers = generalSudokuGame.getSudokuOriginallyOpenedNumbers()
        
        for i in 0...8 {
            for j in 0...8 {
                if originallyOpenedNumbers[i][j] == 0 {
                    _ = generalSudokuGame.fillCell(x: i, y: j, value: 0)
                    filledNumbersView[i][j].text = ""
                    gridView.addSubview(filledNumbersView[i][j])
                }
            }
        }
        
        saveInfo()
        
        completeGameView.removeFromSuperview()
    }
    
    func continueGameAfterLose() {
        completeGameView.removeFromSuperview()
    }
    
    func saveInfo() {
        if isSaving {
            gamesInfoCoding.encode(game: generalSudokuGame)
        }
    }
    
    func clearCellNotes(x: Int, y: Int) {
        for i in 0...8 {
            notesLabels[x][y][i].text = ""
        }
        generalSudokuGame.clearCellNotes(x: x, y: y)
    }
    
    func clearCellFromMainNumber(x: Int, y: Int) {
        if generalSudokuGame.deleteCellNumber(x: x, y: y) {
            saveInfo()
            
            filledNumbersView[x][y].text = ""
        }
    }
    
    func ifAllCellsFilledDisplayCompletionView() {
        if generalSudokuGame.checkIfAllCellsFilled() {
            view.addSubview(completeGameView)
            
            if generalSudokuGame.checkIfAllCellsRight() {
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
