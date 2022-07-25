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
    
    var gamesName: [String] = AllGames().myGames.map { $0.key }.sorted()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myGamesTableView.dataSource = self
        myGamesTableView.delegate = self
        
        myGamesTableView.register(MyGameTableViewCell.self, forCellReuseIdentifier: "gameCell")
        
        setTableSettings()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        myGamesTableView.addGestureRecognizer(longPress)
        
        configureInfoAppButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateGamesList()
    }
    
    func configureInfoAppButton() {
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoItemTapped))
        self.navigationItem.rightBarButtonItem  = button
    }
    
    @objc func infoItemTapped() {
        
        let alert = UIAlertController(title: "App Info", message: "If you have any suggestions or questions, please write them to this email: sudokuCoGame@outlook.com", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Write", style: .default, handler: { _ in
            let email = "sudokuCoGame@outlook.com"
            if let url = URL(string: "mailto:\(email)") {
              if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
              } else {
                UIApplication.shared.openURL(url)
              }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
            
            var gameInfoCoding = GamesInfoCoding()
            gameInfoCoding.configureInfoForSaving(gameName: gameName)
            gameInfoCoding.deleteGameInfo()
            
            var statsGameCoding = StatisticGameCoding()
            statsGameCoding.configureInfoForSaving(gameName: gameName)
            statsGameCoding.deleteGameInfo()
            
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
        
        
        var gamesCoding = GamesInfoCoding()
        gamesCoding.configureInfoForSaving(gameName: gameName)
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
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isOpenLibraryAlert = false
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Odd-Even Sudoku":
            let sudokuGameVC = OddEvenSudokuViewController()
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isOpenLibraryAlert = false
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Frame Sudoku":
            let sudokuGameVC = FrameSudokuViewController()
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isOpenLibraryAlert = false
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Dots Sudoku":
            let sudokuGameVC = DotsSudokuViewController()
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isOpenLibraryAlert = false
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Comparison Sudoku":
            let sudokuGameVC = ComparisonSudokuViewController()
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isOpenLibraryAlert = false
            sudokuGameVC.gameMode = gameMode
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        default: return
        }
    }
    
    func updateGamesList() {
        gamesName = AllGames().myGames.map { $0.key }.sorted()
        allGames = AllGames()
        myGamesTableView.reloadData()
    }
}

extension MyGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gamesName.count == 0 {
            tableView.setEmptyView(mainText: "There are no games yet", addText: "Go to Game Library")
        } else {
            tableView.restore()
        }
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
