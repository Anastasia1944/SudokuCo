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
    
    func openMenuAlert(gameName: String) {
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.transitionToGameVC(gameName, gameMode: "Continue")
        }))
        
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { _ in
            self.transitionToGameVC(gameName, gameMode: "New Game")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {})
        
    }
    
    func transitionToGameVC(_ gameName: String, gameMode: String) {
        let sudokuClassicVC = SudokuClassicViewController()
        sudokuClassicVC.modalPresentationStyle = .fullScreen
        sudokuClassicVC.gameMode = gameMode
        
        navigationController?.pushViewController(sudokuClassicVC, animated: true)
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
            self.openMenuAlert(gameName: self.myGames[indexPath.row])
        }
        return gameCell
    }
}
