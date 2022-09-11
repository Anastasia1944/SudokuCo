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
    
    var gamesName: [GamesNames] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .whiteSys
        
        myGamesTableView.dataSource = self
        myGamesTableView.delegate = self
        
        gamesName = allGames.getMyGamesNames().sorted(by: {$0.rawValue < $1.rawValue})
        
        setTableSettings()
        
        configureInfoAppButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateGamesList()
    }
    
    func configureInfoAppButtons() {
        let infoButtonImg = UIImage(systemName: "info.circle")
        let settingsButtonImg = UIImage(systemName: "gearshape")
        
        let infoButton = UIBarButtonItem(image: infoButtonImg, style: .plain, target: self, action: #selector(infoItemTapped))
        let settingsButton = UIBarButtonItem(image: settingsButtonImg, style: .plain, target: self, action: #selector(settingsButtonTapped))
        
        navigationItem.rightBarButtonItems = [infoButton, settingsButton]
    }
    
    @objc func infoItemTapped() {
        let alert = UIAlertController(title: NSLocalizedString("App Info", comment: ""), message: NSLocalizedString("Feedback", comment: ""), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Write", comment: ""), style: .default, handler: { _ in
            let email = "sudokuCoGame@outlook.com"
            if let url = URL(string: "mailto:\(email)") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func settingsButtonTapped() {
        let settingsVC = SettingsViewController()
        
        navigationController?.pushViewController(settingsVC, animated: true)
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
    
    func openDeleteAlert(gameName: GamesNames) {
        let alert = UIAlertController(title: NSLocalizedString("Delete", comment: "") + " " + gameName.rawValue + " " + NSLocalizedString("From My Games", comment: ""), message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: { _ in
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
    
    func openMenuAlert(gameName: GamesNames) {
        let alert = UIAlertController()
        
        let levels = DifficultyLevels.allCases.map{ $0 }
        
        for level in levels {
            alert.addAction(UIAlertAction(title: NSLocalizedString(level.rawValue, comment: ""), style: .default, handler: { _ in
                self.transitionToGameVC(gameName, gameLevel: level)
            }))
        }
        
        if gamesInfoCoding.isThereUnfinishedGame(gameName: gameName) {
            alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: .default, handler: { _ in
                self.transitionToGameVC(gameName, isNewGame: false)
            }))
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {})
    }
    
    func transitionToGameVC(_ gameName: GamesNames, isNewGame: Bool = true, gameLevel: DifficultyLevels = .easy) {
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
        gamesName = allGames.getMyGamesNames().sorted(by: {$0.rawValue < $1.rawValue})
        myGamesTableView.reloadData()
    }
}

extension MyGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gamesName.count == 0 {
            tableView.setEmptyView(mainText: NSLocalizedString("No Games Yet", comment: ""), addText: NSLocalizedString("Go to Game Library", comment: ""))
        } else {
            tableView.restore()
        }
        return gamesName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! MyGameTableViewCell
        
        let gameName = gamesName[indexPath.row]
        
        gameCell.gameLabel.text = gameName.rawValue
        gameCell.gameImageView.image = UIImage(named: allGames.getGameImageNameByName(gameName: gameName) ?? "")
        
        return gameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openMenuAlert(gameName: gamesName[indexPath.row])
    }
}
