//
//  OddEvenSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 24.06.2022.
//

import UIKit

class OddEvenSudokuViewController: UIViewController {
    
    var gameMode: String?
    
    let gridView = SudokuGridView()
    let sudokuPanelStackView = UIStackView()
    let numberPanelStackView = UIStackView()
    
    let selectedCellView = UIView()
    var filledNumbersView: [[UILabel]] = [[]]
    
    var cellSize = CGFloat(0)
    
    var oddEvenSudokuGame = OddEvenSudokuGame()
    
    var gamesInfoCoding = GamesInfoCoding(file: AllGames().games["Odd-Even Sudoku"]!.gameInfoFile, gameName: "Odd-Even Sudoku")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        if gameMode == "Continue" {
            continueGame()
        } else {
            newGame()
        }
        
        fillCells()
    }
    
    func newGame() {
        oddEvenSudokuGame.generateSudoku()
        
        gamesInfoCoding.encode(game: oddEvenSudokuGame)
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
        
        configureSudokuGrid()
        configurePanel()
        configureNumberPanel()
    }
    
    func configureSudokuGrid() {
        
        let gap = CGFloat(10)
        gridView.setGap(gap)
        gridView.formView()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.gridView.addGestureRecognizer(gesture)
        
        cellSize = gridView.getCellSize()
        
        self.view.addSubview(gridView)
        
        gridView.translatesAutoresizingMaskIntoConstraints = false
        gridView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -gap).isActive = true
        gridView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: gap).isActive = true
        gridView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
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
            switch buttonIcons[i] {
            case "arrow.counterclockwise": button.addTarget(self, action: #selector(tapPanelButtonCancel), for: .touchUpInside)
            case "delete.left": button.addTarget(self, action: #selector(tapPanelButtonDelete), for: .touchUpInside)
            case "lightbulb": button.addTarget(self, action: #selector(tapPanelButtonTip), for: .touchUpInside)
            default:
                return
            }
            
            sudokuPanelStackView.addArrangedSubview(button)
        }
        
        sudokuPanelStackView.translatesAutoresizingMaskIntoConstraints = false
        sudokuPanelStackView.topAnchor.constraint(equalTo: gridView.bottomAnchor, constant: 30).isActive = true
        sudokuPanelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        sudokuPanelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        sudokuPanelStackView.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
    }
    
    @objc func tapPanelButtonCancel(sender: UIButton!){
        
        if let lastAction = oddEvenSudokuGame.cancelAction() {
            
            selectedCellView.frame = CGRect(x: CGFloat(lastAction.xCell) * cellSize, y: CGFloat(lastAction.yCell) * cellSize, width: cellSize, height: cellSize)
            
            gamesInfoCoding.encode(game: oddEvenSudokuGame)
            
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
        
        let cellX = Int(selectedCellView.frame.minX / cellSize)
        let cellY = Int(selectedCellView.frame.minY / cellSize)
        
        if oddEvenSudokuGame.deleteCellNumber(x: cellX, y: cellY) {
            gamesInfoCoding.encode(game: oddEvenSudokuGame)
            filledNumbersView[cellX][cellY].text = ""
            gridView.addSubview(filledNumbersView[cellX][cellY])
        }
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!){
        
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let cellX = Int(selectedCellView.frame.minX / cellSize)
        let cellY = Int(selectedCellView.frame.minY / cellSize)
        
        if oddEvenSudokuGame.isNumberOpened(x: cellX, y: cellY) == false {
            let number = oddEvenSudokuGame.fillCellbyRightNumber(x: cellX, y: cellY)
            gamesInfoCoding.encode(game: oddEvenSudokuGame)
            filledNumbersView[cellX][cellY].text = String(number)
            gridView.addSubview(filledNumbersView[cellX][cellY])
        }
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
            button.addTarget(self, action: #selector(tapNumberPanelButton), for: .touchUpInside)
            numberPanelStackView.addArrangedSubview(button)
        }
        
        numberPanelStackView.translatesAutoresizingMaskIntoConstraints = false
        numberPanelStackView.topAnchor.constraint(equalTo: sudokuPanelStackView.bottomAnchor, constant: 30).isActive = true
        numberPanelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        numberPanelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        numberPanelStackView.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
    }
    
    @objc func tapNumberPanelButton(sender: UIButton!){
        
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let cellX = Int(selectedCellView.frame.minX / cellSize)
        let cellY = Int(selectedCellView.frame.minY / cellSize)
        let value = sender.titleLabel!.text!
        
        if oddEvenSudokuGame.fillCell(x: cellX, y: cellY, value: Int(value)!) {
            gamesInfoCoding.encode(game: oddEvenSudokuGame)
            filledNumbersView[cellX][cellY].text = value
            gridView.addSubview(filledNumbersView[cellX][cellY])
        }
    }
}
