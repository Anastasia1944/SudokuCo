//
//  GeneralSudokuViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 02.07.2022.
//

import UIKit

class GeneralSudokuViewController: UIViewController {
    
    let gameController = GeneralSudokuController()
    var gameSettings: GameSettings
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.gameSettings = self.gameController.gameSettings
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        gameController.startGame()
        
        if gameSettings.isOpenLibraryAlert {
            openLibraryAlert()
        }
        
        gameController.isTransitionToCompleteVC = { completeVC in
            self.navigationController?.pushViewController(completeVC, animated: true)
        }

        self.title = gameController.gameProcessor.gameState.gameName.rawValue
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blueSys, .font: UIFont.systemFont(ofSize: 20)]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        gameController.stopTimer()
    }
    
    private func configureView() {
        view.backgroundColor = .whiteSys
        
        configureTimeModeStackView()
        configureGameElementsStack()
        configureGridLabels()
        configureNotesLabels()
        configureInfoGameButton()
    }
    
    private func configureTimeModeStackView() {
        let timeModeStackView = gameController.timeModeStackView
        view.addSubview(timeModeStackView)
        
        timeModeStackView.axis = .horizontal
        timeModeStackView.distribution = .equalSpacing
        timeModeStackView.spacing = 20
        
        timeModeStackView.translatesAutoresizingMaskIntoConstraints = false
        timeModeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        timeModeStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        timeModeStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        timeModeStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addModeTimeToStack()
    }
    
    private func addModeTimeToStack() {
        let modeLabel = UILabel()
        modeLabel.textColor = .gray
        
        let currentTimeLabel = UILabel()
        currentTimeLabel.textColor = .gray
        
        gameController.timeModeStackView.addArrangedSubview(modeLabel)
        gameController.timeModeStackView.addArrangedSubview(currentTimeLabel)
    }
    
    private func configureGameElementsStack() {
        let gameElementsStackView = gameController.gameElementsStackView
        view.addSubview(gameElementsStackView)
        
        gameElementsStackView.axis = .vertical
        gameElementsStackView.distribution = .equalSpacing
        gameElementsStackView.spacing = 20
        
        gameElementsStackView.translatesAutoresizingMaskIntoConstraints = false
        gameElementsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        gameElementsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        gameElementsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        configureSudokuGrid()
        configurePanel()
        configureNumberPanel()
    }
    
    private func configureSudokuGrid() {
        let framingGridView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20))
        self.gameController.gameElementsStackView.addArrangedSubview(framingGridView)
        
        framingGridView.translatesAutoresizingMaskIntoConstraints = false
        framingGridView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        
        let gridView = gameController.gridView
        gridView.formView(width: gameSettings.gridWidth, withOuterBoldBorder: gameSettings.withOuterBoldBorder, withBoldAreas: gameSettings.withBoldAreas)
        gridView.frame.size = CGSize(width: gameSettings.gridWidth, height: gameSettings.gridWidth)
        gridView.center = framingGridView.center
        
        let gesture = UITapGestureRecognizer(target: gameController, action: #selector(gameController.tapOnGrid))
        gridView.addGestureRecognizer(gesture)
        
        framingGridView.addSubview(gridView)
    }
    
    private func configurePanel() {
        let sudokuPanelStackView = gameController.sudokuPanelStackView
        
        gameController.gameElementsStackView.addArrangedSubview(sudokuPanelStackView)
        
        sudokuPanelStackView.axis = .horizontal
        sudokuPanelStackView.distribution = .fillEqually
        sudokuPanelStackView.spacing = 2
        
        let buttonIcons = ["arrow.counterclockwise", "delete.left", "square.and.pencil", "lightbulb"]
        let buttonLabelsTexts = [NSLocalizedString("Continue", comment: ""), NSLocalizedString("Delete", comment: ""), NSLocalizedString("Notes", comment: ""), NSLocalizedString("Tip", comment: "")]
        
        for i in 0..<buttonIcons.count {
            
            let buttonStackView = UIStackView()
            buttonStackView.axis = .vertical
            buttonStackView.distribution = .equalSpacing
            buttonStackView.spacing = 4
            buttonStackView.alignment = .center
            
            let button = UIButton(type: .system)
            let label = UILabel()
            label.text = buttonLabelsTexts[i]
            
            buttonStackView.addArrangedSubview(button)
            buttonStackView.addArrangedSubview(label)
            
            let image = UIImage(systemName: buttonIcons[i], withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))?.withTintColor(.blackSys, renderingMode: .alwaysOriginal)
            let highlightedImage = UIImage(systemName: buttonIcons[i], withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))?.withTintColor(.graySys, renderingMode: .alwaysOriginal)
            
            button.setImage(image, for: .normal)
            button.setImage(highlightedImage, for: .highlighted)
            
            switch buttonIcons[i] {
            case "arrow.counterclockwise": button.addTarget(gameController, action: #selector(gameController.tapPanelButtonCancel), for: .touchUpInside)
            case "delete.left": button.addTarget(gameController, action: #selector(gameController.tapPanelButtonDelete), for: .touchUpInside)
            case "square.and.pencil": button.addTarget(gameController, action: #selector(gameController.tapPanelButtonNote), for: .touchUpInside)
            case "lightbulb": button.addTarget(gameController, action: #selector(gameController.tapPanelButtonTip), for: .touchUpInside)
                
            default:
                return
            }
            sudokuPanelStackView.addArrangedSubview(buttonStackView)
        }
    }
    
    private func configureNumberPanel() {
        switch gameSettings.fillElements {
        case .ints:
            let numberPanelStackView = NumbersPanelView()
            numberPanelStackView.configurePanel(gameController: gameController)
            gameController.numberPanelStackView = numberPanelStackView
            gameController.gameElementsStackView.addArrangedSubview(numberPanelStackView)
        case .letters:
            let lettersPanelStackView = LettersPanelView()
            lettersPanelStackView.configurePanel(gameController: gameController, lettersRange: gameSettings.whichNumsSaved)
            gameController.numberPanelStackView = lettersPanelStackView
            gameController.gameElementsStackView.addArrangedSubview(lettersPanelStackView)
        }
    }
    
    private func configureGridLabels() {
        for i in Constants.sudokuRange {
            gameController.filledNumbersLabels.append([])
            for j in Constants.sudokuRange {
                let label = UILabel(frame: CGRect(x: Double(i) * gameSettings.cellSize, y: Double(j) * gameSettings.cellSize, width: gameSettings.cellSize, height: gameSettings.cellSize))
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 28)
                
                gameController.filledNumbersLabels[i].append(label)
                gameController.gridView.addSubview(gameController.filledNumbersLabels[i][j])
            }
        }
    }
    
    private func configureNotesLabels() {
        let gap = 3.0
        let cellSize = gameSettings.cellSize
        let gapNotesShift = gameSettings.gapNotesShift
        
        for i in Constants.sudokuRange {
            gameController.notesLabels.append([])
            for j in Constants.sudokuRange {
                gameController.notesLabels[i].append([])
                for k in Constants.sudokuRange {
                    let xSize = Double(i) * cellSize + Double(k % 3) * (cellSize - 2 * gap - gapNotesShift) / 3
                    let ySize = Double(j) * cellSize + Double(k / 3) * (cellSize - 2 * gap - gapNotesShift) / 3
                    
                    let label = UILabel(frame: CGRect(x: xSize + gap + gapNotesShift, y: ySize + gap + gapNotesShift, width: (cellSize - 2 * gap - gapNotesShift) / 3, height: (cellSize - 2 * gap - gapNotesShift) / 3))
                    label.textAlignment = .center
                    label.textColor = .darkGray
                    label.font = .systemFont(ofSize: 9)
                    
                    gameController.notesLabels[i][j].append(label)
                    gameController.gridView.addSubview(gameController.notesLabels[i][j][k])
                }
            }
        }
    }
    
    private func configureInfoGameButton() {
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoItemTapped))
        self.navigationItem.rightBarButtonItem  = button
    }
    
    @objc func infoItemTapped() {
        let gameInfoVC = GameInfoViewController()
        gameInfoVC.gameName = gameSettings.gameName
        
        navigationController?.pushViewController(gameInfoVC, animated: true)
    }
    
    private func openLibraryAlert() {
        let alert = UIAlertController(title: NSLocalizedString("Statistics Not Saving", comment: ""), message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Don't show again", comment: ""), style: .default, handler: { _ in
            let defaults = UserDefaults.standard
            
            defaults.set(true, forKey: "Do not Show Library Alert")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
