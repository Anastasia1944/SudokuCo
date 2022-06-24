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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameLibraryTableView.dataSource = self
        gameLibraryTableView.delegate = self
        
        gameLibraryTableView.register(MyGameTableViewCell.self, forCellReuseIdentifier: "gameCell")
        
        tableSettings()
    }
    
    func tableSettings() {
        view.addSubview(gameLibraryTableView)
        
        gameLibraryTableView.separatorStyle = .none
        gameLibraryTableView.allowsSelection = false
        
        gameLibraryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        gameLibraryTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        gameLibraryTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        gameLibraryTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        gameLibraryTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func openAddGameAlert(gameName: String) {
        let alert = UIAlertController(title: "Add \"\(gameName)\" to My Games?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            self.allGames.myGames[gameName] = self.allGames.games[gameName]
            self.allGames.saveGames()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension GameLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGames.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as! MyGameTableViewCell
        var gameName = ""
        for game in allGames.games.keys {
            gameName = game
            gameCell.gameButton.setTitle(gameName, for: .normal)
        }
        gameCell.buttonTapCallback = {
            self.openAddGameAlert(gameName: gameName)
        }
        return gameCell
    }
}
