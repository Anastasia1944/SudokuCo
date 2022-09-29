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
        
        self.view.backgroundColor = .beige
        
        gameLibraryTableView.dataSource = self
        gameLibraryTableView.delegate = self
        
        gamesName = allGames.getAllGamesNames().sorted(by: {$0.rawValue < $1.rawValue})
        
        navBarSettings()
        tableSettings()
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
    
    func tableSettings() {
        view.addSubview(gameLibraryTableView)
        
        gameLibraryTableView.register(GamesListTableViewCell.self, forCellReuseIdentifier: "gameCell")
        
        gameLibraryTableView.backgroundColor = .clear
        gameLibraryTableView.separatorStyle = .none
        gameLibraryTableView.allowsSelection = false
        
        gameLibraryTableView.translatesAutoresizingMaskIntoConstraints = false
        gameLibraryTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        gameLibraryTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        gameLibraryTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        gameLibraryTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let gameName = GamesNames(rawValue: sender.accessibilityLabel!)!
            openAddGameAlert(gameName: gameName)
        }
    }
    
    func openAddGameAlert(gameName: GamesNames) {
        let alert = UIAlertController(title: NSLocalizedString("Add", comment: "") + " " + gameName.rawValue + " " + NSLocalizedString("To My Games", comment: ""), message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Add", comment: ""), style: .default, handler: { _ in
            self.allGames.addGameToMyGames(gameName: gameName)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func transitionToGameVC(sender: UIButton!) {
        let gameNameEnum = GamesNames(rawValue: sender.accessibilityLabel!)!
        
        let stringVC = allGames.getVCNameByGameName(gameName: gameNameEnum)
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
        return (gamesName.count + 1) / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as! GamesListTableViewCell
        
        for i in indexPath.row * 2...indexPath.row * 2 + 1 {
            let button = UIButton()
            let label = UILabel()
            
            gameCell.buttonsLabels.append((button, label))
            
            if !(i == indexPath.row * 2 + 1 && i >= gamesName.count) {
                let gameName = gamesName[i]
                
                let image = UIImage(named: allGames.getGameImageNameByName(gameName: gameName) ?? "")
                button.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
                button.accessibilityLabel = gameName.rawValue
                label.text = gameName.rawValue
                
                button.addTarget(self, action: #selector(transitionToGameVC), for: .touchUpInside)
                
                let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
                longPress.accessibilityLabel = gameName.rawValue
                button.addGestureRecognizer(longPress)
            }
        }
        
        gameCell.addGames()
        
        return gameCell
    }
}
