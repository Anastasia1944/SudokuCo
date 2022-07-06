//
//  GeneralSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 02.07.2022.
//

import UIKit

class GeneralSudokuViewController: UIViewController {
    
    let gridView = SudokuGridView()
    let sudokuPanelStackView = UIStackView()
    let numberPanelStackView = UIStackView()
    let gameElementsStackView = UIStackView()
    
    var filledNumbersLabels: [[UILabel]] = []
    var notesLabels: [[[UILabel]]] = []
    let selectedCellView = UIView()
    
    var gridWidth = CGFloat(0)
    var cellSize = CGFloat(0)
    
    var gameMode: String = "New Game"
    var isSaving: Bool = true
    var openedNum = CGFloat(0)
    
    let testController = GeneralSudokuController()
    
    let completeGameView = CompleteGameView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        testController.numberChanged = { numbers in
            for i in 0...8 {
                for j in 0...8 {
                    if numbers[i][j] != 0 {
                        self.filledNumbersLabels[i][j].text = String(numbers[i][j])
                    } else {
                        self.filledNumbersLabels[i][j].text = ""
                    }
                }
            }
            
            guard let isCompleteGame = self.testController.ifAllCellsFilledDisplayCompletionView() else { return }
            
            self.view.addSubview(self.completeGameView)
            
            if isCompleteGame {
                self.completeGameView.configureView(isWinning: true)
            } else {
                self.completeGameView.configureView(isWinning: false)
            }
        }
        
        testController.noteNumberChanged = { numbers in
            for i in 0...8 {
                for j in 0...8 {
                    for k in 1...9 {
                        if numbers[i][j][k] == true {
                            self.notesLabels[i][j][k - 1].text = String(k)
                        } else {
                            self.notesLabels[i][j][k - 1].text = ""
                        }
                    }
                }
            }
        }
        
        testController.configureController(gameMode: gameMode, openedNum: openedNum, isSaving: isSaving)
        
        completeGameView.userAnswer = { buttonAnswer in
            switch buttonAnswer {
            case "Main Menu": self.quitToMainMenu()
            case "Start Over": self.startOver()
            case "Continue": self.continueGameAfterLose()
            default: return
            }
        }
        
    }
    
    func quitToMainMenu() {
        navigationController?.popViewController(animated: true)
    }
    
    func startOver() {
        
        testController.startGameOver()
        
        completeGameView.removeFromSuperview()
    }
    
    func continueGameAfterLose() {
        completeGameView.removeFromSuperview()
    }
    
    func configureInit(gridWidth: CGFloat = UIScreen.main.bounds.width - 20) {
        self.gridWidth = gridWidth
        self.cellSize = gridWidth / 9
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        configureGameElementsStack()
        configureGridLabels()
        configureNotesLabels()
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
        selectedCellView.backgroundColor = .graySys
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
        _ = testController.cancelButtonTapped()
    }
    
    @objc func tapPanelButtonDelete(sender: UIButton!) {
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        testController.deleteButtonTapped(x: cellX, y: cellY)
    }
    
    @objc func tapPanelButtonNote(sender: UIButton!) {
        testController.noteButtonTapped()
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!) {
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        testController.tipButtonTapped(x: cellX, y: cellY)
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
            numberPanelStackView.addArrangedSubview(button)
        }
    }
    
    @objc func tapNumberPanelButton(sender: UIButton!){
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        let value = sender.titleLabel!.text!
        
        testController.numberButtonTapped(x: cellX, y: cellY, value: Int(value)!)
    }
    
    func configureGridLabels() {

        for i in 0...8 {
            filledNumbersLabels.append([])
            for j in 0...8 {
                let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: CGFloat(j) * cellSize, width: cellSize, height: cellSize))
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 28)
                
                filledNumbersLabels[i].append(label)
                gridView.addSubview(filledNumbersLabels[i][j])
            }
        }
    }
    
    func configureNotesLabels() {
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
    
    func getCellsByCoordinates() -> (x: Int, y: Int) {
        let x = Int(floor(selectedCellView.frame.midX / cellSize))
        let y = Int(floor(selectedCellView.frame.midY / cellSize))
        return (x, y)
    }
}