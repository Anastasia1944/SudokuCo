//
//  GameLibraryViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.06.2022.
//

import UIKit

class GameLibraryViewController: UIViewController {
    
    let gameLibraryTableView = UITableView()
    
    var allGames = AllGames()
    
    var gamesName: [GamesNames] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .graySys
        
        gameLibraryTableView.dataSource = self
        gameLibraryTableView.delegate = self
        
        gamesName = allGames.getAllGamesNames().sorted(by: {$0.rawValue < $1.rawValue})

        tableSettings()
    }
    
    func tableSettings() {
        view.addSubview(gameLibraryTableView)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        gameLibraryTableView.addGestureRecognizer(longPress)
        
        gameLibraryTableView.register(MyGameTableViewCell.self, forCellReuseIdentifier: "gameCell")
        
        gameLibraryTableView.separatorStyle = .none
        gameLibraryTableView.rowHeight = 100.0
        
        gameLibraryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        gameLibraryTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        gameLibraryTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        gameLibraryTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        gameLibraryTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
    
    func openAddGameAlert(gameName: GamesNames) {
        let alert = UIAlertController(title: "Add \"\(gameName)\" to My Games?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            self.allGames.addGameToMyGames(gameName: gameName)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func transitipnToGameVC(gameName: GamesNames) {
        let stringVC = allGames.getVCNameByGameName(gameName: gameName)
        let sudokuGameVC = stringVC!.getViewController()! as! GeneralSudokuViewController
        
        sudokuGameVC.hidesBottomBarWhenPushed = true
        sudokuGameVC.modalPresentationStyle = .fullScreen
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "Do not Show Library Alert") {
            sudokuGameVC.gameSettings.isOpenLibraryAlert = false
        }
        sudokuGameVC.gameSettings.isSaving = false
        
        navigationController?.pushViewController(sudokuGameVC, animated: true)
    }
}

extension GameLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as! MyGameTableViewCell
        
        let gameName = gamesName[indexPath.row]
        
        gameCell.gameLabel.text = gameName.rawValue
        gameCell.gameImageView.image = UIImage(named: allGames.getGameImageNameByName(gameName: gameName) ?? "")
        
        return gameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.transitipnToGameVC(gameName: gamesName[indexPath.row])
    }
}
