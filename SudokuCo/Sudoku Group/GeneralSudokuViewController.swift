//
//  GeneralSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 02.07.2022.
//

import UIKit

class GeneralSudokuViewController: UIViewController {
    
    let gridView = GridView()
    let sudokuPanelStackView = UIStackView()
    let numberPanelStackView = UIStackView()
    let gameElementsStackView = UIStackView()
    
    var filledNumbersLabels: [[UILabel]] = []
    var notesLabels: [[[UILabel]]] = []
    let selectedCellView = UIView()
    var numbersButtons: [UIButton] = []
    var originallyOpenedNumbers: [[Int]] = []
    
    var gridWidth = CGFloat(0)
    var cellSize = CGFloat(0)
    
    var gameMode: String = "Easy"
    var gameLevel: DifficultyLevels = .easy
    var isSaving: Bool = true
    var openedNum = CGFloat(0)
    var gameName: String = ""
    var gameTime: Int = 0
    var sudokuType: SudokuTypes = .sudoku3D
    var withOuterBoldBorder: Bool = true
    var withBoldAreas: Bool = true
    var gapNotesShift: CGFloat = CGFloat(0)
    
    var generalSudokuController = GeneralSudokuController()
    
    var isOpenLibraryAlert: Bool = true
    
    var tipLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        generalSudokuController.numberChanged = { numbers in
            self.fillNumbers(sudokuNumbers: numbers)
            
            if self.generalSudokuController.ifAllCellsFilled() {
                self.gameTime = self.generalSudokuController.stopTimer()
                
                
                if self.generalSudokuController.ifAllCellsFilledRight() {
                    self.transitionToCompleteVC(isWin: true)
                } else {
                    self.displayWrongCells()
                }
//                self.transitionToCompleteVC(isWin: self.generalSudokuController.ifAllCellsFilledRight())
            }
        }
        
        generalSudokuController.noteNumberChanged = { numbers in
            self.fillNotes(sudokuNotes: numbers)
        }
        
        generalSudokuController.noteChanged = { isNote in
            for i in 0...8 {
                self.numbersButtons[i].isSelected = isNote
            }
        }
        
        generalSudokuController.configureController(sudokuType: sudokuType, gameMode: gameMode, openedNum: openedNum, isSaving: isSaving, gameName: gameName)
        
        gameLevel = generalSudokuController.getLevel()
        
        let tipsCount = generalSudokuController.getTipsCount()
        tipLabel.text = "Tip (\(tipsCount))"
        
        originallyOpenedNumbers = generalSudokuController.getOriginallyOpenedNumbers()
        fillOriginallyOpenedNumbers()
        
        configureInfoGameButton()
        
        if isOpenLibraryAlert {
            openLibraryAlert()
        }
    }
    
    
    
    func displayWrongCells() {
        let sudokuNumbers = generalSudokuController.getSudokuNumbers()
        
        for i in 0...8 {
            for j in 0...8 {
                if filledNumbersLabels[i][j].text != String(sudokuNumbers[i][j]) {
                    filledNumbersLabels[i][j].backgroundColor = .red
                }
            }
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        gameTime = generalSudokuController.stopTimer()
    }
    
    private func fillNumbers(sudokuNumbers: [[Int]]) {
        for i in 0...8 {
            for j in 0...8 {
                if sudokuNumbers[i][j] != 0 {
                    self.filledNumbersLabels[i][j].text = String(sudokuNumbers[i][j])
                } else {
                    self.filledNumbersLabels[i][j].text = ""
                }
            }
        }
    }
    
    private func fillNotes(sudokuNotes: [[[Int: Bool]]]) {
        for i in 0...8 {
            for j in 0...8 {
                for k in 1...9 {
                    if sudokuNotes[i][j][k] == true {
                        self.notesLabels[i][j][k - 1].text = String(k)
                    } else {
                        self.notesLabels[i][j][k - 1].text = ""
                    }
                }
            }
        }
    }
    
    private func transitionToCompleteVC(isWin: Bool) {
        let completeVC = CompleteViewController()
        
        completeVC.configureCompleteVC(isWin: isWin, time: self.gameTime, gameName: self.gameName, isSaving: self.isSaving, level: self.gameLevel)
        
        self.navigationController?.pushViewController(completeVC, animated: true)
        
        completeVC.startOver = { start in
            self.generalSudokuController.startGameOver()
        }
        
        completeVC.continueGame = { continueGame in
            self.generalSudokuController.continueCurrentGame()
        }
    }
    
    private func openLibraryAlert() {
        let alert = UIAlertController(title: "This Game will not be saved in statistics. Play from the \"My Games\" to save it.", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Don't show again", style: .default, handler: { _ in
            let defaults = UserDefaults.standard
            
            defaults.set(true, forKey: "Do not Show Library Alert")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureInfoGameButton() {
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoItemTapped))
        self.navigationItem.rightBarButtonItem  = button
    }
    
    @objc func infoItemTapped() {
        let gameInfoVC = GameInfoViewController()
        gameInfoVC.gameName = gameName
        
        navigationController?.pushViewController(gameInfoVC, animated: true)
    }
    
    func configureInit(gridWidth: CGFloat = UIScreen.main.bounds.width - 20) {
        self.gridWidth = gridWidth
        self.cellSize = gridWidth / 9
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        configureGameElementsStack()
        configureGridLabels()
        configureNotesLabels()
    }
    
    private func configureGameElementsStack() {
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
    
    private func configureSudokuGrid() {
        let framingGridView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20))
        self.gameElementsStackView.addArrangedSubview(framingGridView)
        
        framingGridView.translatesAutoresizingMaskIntoConstraints = false
        framingGridView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        
        gridView.formView(width: gridWidth, withOuterBoldBorder: withOuterBoldBorder, withBoldAreas: withBoldAreas)
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
    
    private func configurePanel() {
        self.gameElementsStackView.addArrangedSubview(sudokuPanelStackView)
        
        sudokuPanelStackView.axis = .horizontal
        sudokuPanelStackView.distribution = .fillEqually
        sudokuPanelStackView.spacing = 2
        
        let buttonIcons = ["arrow.counterclockwise", "delete.left", "square.and.pencil", "lightbulb"]
        
        for i in 0..<buttonIcons.count {
            
            let buttonStackView = UIStackView()
            buttonStackView.axis = .vertical
            buttonStackView.distribution = .equalSpacing
            buttonStackView.spacing = 4
            buttonStackView.alignment = .center
            
            let button = UIButton(type: .system)
            let label = UILabel()
            
            if i == 3 {
                tipLabel = label
            }
            
            buttonStackView.addArrangedSubview(button)
            buttonStackView.addArrangedSubview(label)
            
            let image = UIImage(systemName: buttonIcons[i], withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))?.withTintColor(.blackSys, renderingMode: .alwaysOriginal)
            let highlightedImage = UIImage(systemName: buttonIcons[i], withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))?.withTintColor(.graySys, renderingMode: .alwaysOriginal)
            
            button.setImage(image, for: .normal)
            button.setImage(highlightedImage, for: .highlighted)
            
            switch buttonIcons[i] {
            case "arrow.counterclockwise": button.addTarget(self, action: #selector(tapPanelButtonCancel), for: .touchUpInside)
                label.text = "Cancel"
            case "delete.left": button.addTarget(self, action: #selector(tapPanelButtonDelete), for: .touchUpInside)
                label.text = "Delete"
            case "square.and.pencil": button.addTarget(self, action: #selector(tapPanelButtonNote), for: .touchUpInside)
                label.text = "Notes"
            case "lightbulb": button.addTarget(self, action: #selector(tapPanelButtonTip), for: .touchUpInside)
                label.text = "Tip (3)"
            default:
                return
            }
            sudokuPanelStackView.addArrangedSubview(buttonStackView)
        }
    }
    
    @objc func tapPanelButtonCancel(sender: UIButton!) {
        generalSudokuController.cancelButtonTapped()
    }
    
    @objc func tapPanelButtonDelete(sender: UIButton!) {
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        generalSudokuController.deleteButtonTapped(x: cellX, y: cellY)
    }
    
    @objc func tapPanelButtonNote(sender: UIButton!) {
        generalSudokuController.noteButtonTapped()
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!) {
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let (cellX, cellY) = getCellsByCoordinates()
        
        let tipsCount = generalSudokuController.tipButtonTapped(x: cellX, y: cellY)
        
        tipLabel.text = "Tip (\(tipsCount))"
    }
    
    private func configureNumberPanel() {
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
        
        generalSudokuController.numberButtonTapped(x: cellX, y: cellY, value: Int(value)!)
    }
    
    private func configureGridLabels() {
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
    
    private func configureNotesLabels() {
        let gap = CGFloat(3)
        
        for i in 0...8 {
            notesLabels.append([])
            for j in 0...8 {
                notesLabels[i].append([])
                for k in 0...8 {
                    let xSize = CGFloat(i) * cellSize + CGFloat(k % 3) * (cellSize - 2 * gap - gapNotesShift) / 3
                    let ySize = CGFloat(j) * cellSize + CGFloat(k / 3) * (cellSize - 2 * gap - gapNotesShift) / 3
                    
                    let label = UILabel(frame: CGRect(x: xSize + gap + gapNotesShift, y: ySize + gap + gapNotesShift, width: (cellSize - 2 * gap - gapNotesShift) / 3, height: (cellSize - 2 * gap - gapNotesShift) / 3))
                    label.textAlignment = .center
                    label.textColor = .darkGray
                    label.font = .systemFont(ofSize: 9)
                    
                    notesLabels[i][j].append(label)
                    gridView.addSubview(notesLabels[i][j][k])
                }
            }
        }
    }
    
    func fillOriginallyOpenedNumbers() {
        originallyOpenedNumbers = generalSudokuController.getOriginallyOpenedNumbers()
        for i in 0...8 {
            for j in 0...8 {
                if originallyOpenedNumbers[i][j] != 0 {
                    filledNumbersLabels[i][j].textColor = .gray
                    filledNumbersLabels[i][j].text = String(originallyOpenedNumbers[i][j])
                } else {
                    filledNumbersLabels[i][j].text = ""
                }
            }
        }
    }
    
    private func getCellsByCoordinates() -> (x: Int, y: Int) {
        let x = Int(floor(selectedCellView.frame.midX / cellSize))
        let y = Int(floor(selectedCellView.frame.midY / cellSize))
        return (x, y)
    }
}
