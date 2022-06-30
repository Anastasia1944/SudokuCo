//
//  MyGamesViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.06.2022.
//

import UIKit

class MyGamesViewController: UIViewController {
    
    let myGamesTableView = UITableView()
    
    var allGames = AllGames()
    
    var gamesName: [String] = AllGames().myGames.map { $0.key }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myGamesTableView.dataSource = self
        myGamesTableView.delegate = self
        
        myGamesTableView.register(MyGameTableViewCell.self, forCellReuseIdentifier: "gameCell")
        
        setTableSettings()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        myGamesTableView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: myGamesTableView)
            if let indexPath = myGamesTableView.indexPathForRow(at: touchPoint) {
                let gameName = gamesName[indexPath.row]
                openDeleteAlert(gameName: gameName)
            }
        }
    }
    
    func openDeleteAlert(gameName: String) {
        let alert = UIAlertController(title: "Delete \"\(gameName)\" from My Games?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            
            let gameInfoCoding = GamesInfoCoding(gameName: gameName)
            gameInfoCoding.deleteGameInfo()
            
            self.allGames.deleteMyGame(gameName: gameName)
            self.updateGamesList()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setTableSettings() {
        
        view.addSubview(myGamesTableView)
        
        myGamesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        myGamesTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        myGamesTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myGamesTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myGamesTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        myGamesTableView.rowHeight = 100.0
        
        myGamesTableView.separatorStyle = .none
    }
    
    func openMenuAlert(gameName: String) {
        let alert = UIAlertController()
        
        
        var gamesCoding = GamesInfoCoding(gameName: gameName)
        _ = gamesCoding.decode()
        
        if gamesCoding.isThereUnfinishedGame {
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                self.transitionToGameVC(gameName, gameMode: "Continue")
            }))
        }
        
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { _ in
            self.transitionToGameVC(gameName, gameMode: "New Game")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {})
        
    }
    
    func transitionToGameVC(_ gameName: String, gameMode: String) {
        
        switch gameName {
        case "Classic Sudoku":
            let sudokuGameVC = SudokuClassicViewController()
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Odd-Even Sudoku":
            let sudokuGameVC = OddEvenSudokuViewController()
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Frame Sudoku":
            let sudokuGameVC = FrameSudokuViewController()
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Dots Sudoku":
            let sudokuGameVC = DotsSudokuViewController()
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Comparison Sudoku":
            let sudokuGameVC = ComparisonSudokuViewController()
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        default: return
        }
    }
    
    func updateGamesList() {
        gamesName = AllGames().myGames.map { $0.key }
        allGames = AllGames()
        myGamesTableView.reloadData()
    }
}

extension MyGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! MyGameTableViewCell
        
        let gameName = gamesName[indexPath.row]
        
        gameCell.gameLabel.text = gameName
        gameCell.gameImageView.image = UIImage(named: allGames.games[gameName]!.gameImageName)
        
        return gameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openMenuAlert(gameName: gamesName[indexPath.row])
    }
}
