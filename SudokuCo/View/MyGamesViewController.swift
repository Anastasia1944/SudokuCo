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
        
        self.view.backgroundColor = .beige
        
        myGamesTableView.dataSource = self
        myGamesTableView.delegate = self
        
        gamesName = allGames.getMyGamesNames().sorted(by: {$0.rawValue < $1.rawValue})
        
        navBarSettings()
        setTableSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateGamesList()
    }
    
    func navBarSettings() {
        navigationItem.title = "SudokuCo"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightBlue, .font: UIFont.systemFont(ofSize: 24)]
        navigationController?.navigationBar.barTintColor = .beige
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .lightBlue
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let gameName = GamesNames(rawValue: sender.accessibilityLabel!)!
            openDeleteAlert(gameName: gameName)
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
        
        myGamesTableView.separatorStyle = .none
        myGamesTableView.allowsSelection = false
        myGamesTableView.backgroundColor = .clear

        myGamesTableView.register(GamesListTableViewCell.self, forCellReuseIdentifier: "gameCell")
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        myGamesTableView.addGestureRecognizer(longPress)
        
        myGamesTableView.translatesAutoresizingMaskIntoConstraints = false
        myGamesTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        myGamesTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myGamesTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myGamesTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func openMenuAlert(sender: UIButton!) {
        let gameNameEnum = GamesNames(rawValue: sender.accessibilityLabel!)!
        
        let alert = UIAlertController()
        
        let levels = DifficultyLevels.allCases.map{ $0 }
        
        for level in levels {
            alert.addAction(UIAlertAction(title: NSLocalizedString(level.rawValue, comment: ""), style: .default, handler: { _ in
                self.transitionToGameVC(gameNameEnum, gameLevel: level)
            }))
        }
        
        if gamesInfoCoding.isThereUnfinishedGame(gameName: gameNameEnum) {
            alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: .default, handler: { _ in
                self.transitionToGameVC(gameNameEnum, isNewGame: false)
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
        return (gamesName.count + 1) / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as! GamesListTableViewCell
        
        let gameNameLeft = gamesName[indexPath.row * 2]
        let image = UIImage(named: allGames.getGameImageNameByName(gameName: gameNameLeft) ?? "")
        gameCell.gameButtonLeft.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        gameCell.gameButtonLeft.accessibilityLabel = gameNameLeft.rawValue
        gameCell.gameNameLabelLeft.text = gameNameLeft.rawValue
        gameCell.gameButtonLeft.addTarget(self, action: #selector(openMenuAlert), for: .touchUpInside)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.accessibilityLabel = gameNameLeft.rawValue
        gameCell.gameButtonLeft.addGestureRecognizer(longPress)
        
        if indexPath.row * 2 + 1 < gamesName.count {
            let gameNameRight = gamesName[indexPath.row * 2 + 1]
            let image = UIImage(named: allGames.getGameImageNameByName(gameName: gameNameRight) ?? "")
            gameCell.gameButtonRight.setImage(image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            gameCell.gameButtonRight.accessibilityLabel = gameNameRight.rawValue
            gameCell.gameNameLabelRight.text = gameNameRight.rawValue
            gameCell.gameButtonRight.addTarget(self, action: #selector(openMenuAlert), for: .touchUpInside)
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            longPress.accessibilityLabel = gameNameRight.rawValue
            gameCell.gameButtonRight.addGestureRecognizer(longPress)
        }
        
        return gameCell
    }
}
