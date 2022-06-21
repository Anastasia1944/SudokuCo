//
//  SudokuClassicViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuClassicViewController: UIViewController {
    
    let gridView = SudokuGridView()
    let sudokuPanelStackView = UIStackView()
    let numberPanelStackView = UIStackView()
    
    let selectedCellView = UIView()
    var filledNumbersView: [[UILabel]] = [[]]
    
    var cellSize = CGFloat(0)
    
    let classicSudokuGame = ClassicSudokuGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        let originallyOpenedNumbers = classicSudokuGame.getSudokuOriginallyOpenedNumbers()
        
        for i in 0...8 {
            filledNumbersView.append([])
            for j in 0...8 {
                let label = UILabel(frame: CGRect(x: CGFloat(i) * cellSize, y: CGFloat(j) * cellSize, width: cellSize, height: cellSize))
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 35)
                if originallyOpenedNumbers[i][j] != 0 {
                    label.text = String(originallyOpenedNumbers[i][j])
                    label.textColor = .darkGray
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
        
        print("cancel")
    }
    
    @objc func tapPanelButtonDelete(sender: UIButton!){
        
        if selectedCellView.frame.maxX == 0.0 {
            return
        }
        
        let cellX = Int(selectedCellView.frame.minX / cellSize)
        let cellY = Int(selectedCellView.frame.minY / cellSize)
        
        if classicSudokuGame.deleteCellNumber(x: cellX, y: cellY) {
            filledNumbersView[cellX][cellY].text = ""
            gridView.addSubview(filledNumbersView[cellX][cellY])
        }
    }
    
    @objc func tapPanelButtonTip(sender: UIButton!){
        
        print("tip")
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
        
        if classicSudokuGame.fillCell(x: cellX, y: cellY, value: Int(value)!) {
            filledNumbersView[cellX][cellY].text = value
            gridView.addSubview(filledNumbersView[cellX][cellY])
        }
    }
}
