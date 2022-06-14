//
//  MyGamesViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.06.2022.
//

import UIKit

class MyGamesViewController: UIViewController {
    
    let myGamesTableView = UITableView()
    
    let myGames = ["Sudoku", "Killer Sudoku"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myGamesTableView.dataSource = self
        myGamesTableView.delegate = self
        
        myGamesTableView.register(MyGameTableViewCell.self, forCellReuseIdentifier: "gameCell")
        
        setTableSettings()
    }
    
    func setTableSettings() {
        
        view.addSubview(myGamesTableView)
        
        myGamesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        myGamesTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        myGamesTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myGamesTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myGamesTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        myGamesTableView.separatorStyle = .none
    }
    
    func transitionToGameVC(game: String) {
        print(game)
    }
}

extension MyGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! MyGameTableViewCell
        gameCell.gameButton.setTitle(myGames[indexPath.row], for: .normal)
        gameCell.buttonTapCallback = {
            self.transitionToGameVC(game: self.myGames[indexPath.row])
        }
        return gameCell
    }
}
