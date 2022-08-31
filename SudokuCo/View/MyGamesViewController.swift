//
//  MyGamesViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.06.2022.
//

import UIKit

class MyGamesViewController: UIViewController {
    
    let gamesInfoCoding = GamesInfoCoding()
    let statsGameCoding = StatisticGameCoding()
    
    let myGamesTableView = UITableView()
    
    var allGames = AllGames()
    
    var gamesName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .graySys
        
        myGamesTableView.dataSource = self
        myGamesTableView.delegate = self
        
        gamesName = allGames.getMyGamesNames().sorted()
        
        setTableSettings()
        
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
            self.gamesInfoCoding.deleteGameInfo(gameName: gameName)
            self.statsGameCoding.deleteGameStatistics(gameName: gameName)
            self.allGames.deleteMyGame(gameName: gameName)
            
            self.updateGamesList()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setTableSettings() {
        view.addSubview(myGamesTableView)
        
        myGamesTableView.register(MyGameTableViewCell.self, forCellReuseIdentifier: "gameCell")
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        myGamesTableView.addGestureRecognizer(longPress)
        
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
        
        let levels = DifficultyLevels.allCases.map{ $0 }
        
        for level in levels {
            alert.addAction(UIAlertAction(title: level.rawValue, style: .default, handler: { _ in
                self.transitionToGameVC(gameName, gameLevel: level)
            }))
        }
        
        if gamesInfoCoding.isThereUnfinishedGame(gameName: gameName) {
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                self.transitionToGameVC(gameName, isNewGame: false)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {})
    }
    
    func transitionToGameVC(_ gameName: String, isNewGame: Bool = true, gameLevel: DifficultyLevels = .easy) {
        let stringVC = allGames.getVCNameByGameName(gameName: gameName)
        let sudokuGameVC = stringVC!.getViewController()! as! GeneralSudokuViewController
        
        sudokuGameVC.hidesBottomBarWhenPushed = true
        sudokuGameVC.modalPresentationStyle = .fullScreen
        
        sudokuGameVC.gameSettings.isOpenLibraryAlert = false
        sudokuGameVC.gameSettings.gameLevel = gameLevel
        sudokuGameVC.gameSettings.isNewGame = isNewGame
        
        navigationController?.pushViewController(sudokuGameVC, animated: true)
    }
    
    func updateGamesList() {
        gamesName = allGames.getMyGamesNames().sorted()
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
        gameCell.gameImageView.image = UIImage(named: allGames.getGameImageNameByName(gameName: gameName) ?? "")
        
        return gameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openMenuAlert(gameName: gamesName[indexPath.row])
    }
}
