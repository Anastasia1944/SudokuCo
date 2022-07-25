//
//  GameLibraryViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.06.2022.
//

import UIKit

class GameLibraryViewController: UIViewController {
    
    let gameLibraryTableView = UITableView()
    
    var gamesName: [String] = AllGames().games.map { $0.key }.sorted()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameLibraryTableView.dataSource = self
        gameLibraryTableView.delegate = self
        
        gameLibraryTableView.register(MyGameTableViewCell.self, forCellReuseIdentifier: "gameCell")
        
        tableSettings()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        gameLibraryTableView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: gameLibraryTableView)
            if let indexPath = gameLibraryTableView.indexPathForRow(at: touchPoint) {
                let gameName = gamesName[indexPath.row]
                openAddGameAlert(gameName: gameName)
            }
        }
    }
    
    func tableSettings() {
        view.addSubview(gameLibraryTableView)
        
        gameLibraryTableView.separatorStyle = .none
        gameLibraryTableView.rowHeight = 100.0
        
        gameLibraryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        gameLibraryTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        gameLibraryTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        gameLibraryTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        gameLibraryTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func openAddGameAlert(gameName: String) {
        var allGames = AllGames()
        
        let alert = UIAlertController(title: "Add \"\(gameName)\" to My Games?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            allGames.myGames[gameName] = allGames.games[gameName]
            allGames.saveGames()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func transitipnToGameVC(gameName: String) {
        
        let defaults = UserDefaults.standard
        
        switch gameName {
        case "Classic Sudoku":
            let sudokuGameVC = SudokuClassicViewController()
            if defaults.bool(forKey: "Do not Show Library Alert") {
                sudokuGameVC.isOpenLibraryAlert = false
            }
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isSaving = false
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Odd-Even Sudoku":
            let sudokuGameVC = OddEvenSudokuViewController()
            if defaults.bool(forKey: "Do not Show Library Alert") {
                sudokuGameVC.isOpenLibraryAlert = false
            }
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isSaving = false
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Frame Sudoku":
            let sudokuGameVC = FrameSudokuViewController()
            if defaults.bool(forKey: "Do not Show Library Alert") {
                sudokuGameVC.isOpenLibraryAlert = false
            }
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isSaving = false
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Dots Sudoku":
            let sudokuGameVC = DotsSudokuViewController()
            if defaults.bool(forKey: "Do not Show Library Alert") {
                sudokuGameVC.isOpenLibraryAlert = false
            }
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isSaving = false
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        case "Comparison Sudoku":
            let sudokuGameVC = ComparisonSudokuViewController()
            if defaults.bool(forKey: "Do not Show Library Alert") {
                sudokuGameVC.isOpenLibraryAlert = false
            }
            sudokuGameVC.hidesBottomBarWhenPushed = true
            sudokuGameVC.isSaving = false
            sudokuGameVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(sudokuGameVC, animated: true)
        default: return
        }
    }
}

extension GameLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as! MyGameTableViewCell
        
        let gameName = gamesName[indexPath.row]
        
        gameCell.gameLabel.text = gameName
        gameCell.gameImageView.image = UIImage(named: AllGames().games[gameName]!.gameImageName)
        
        return gameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.transitipnToGameVC(gameName: gamesName[indexPath.row])
    }
}
