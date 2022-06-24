//
//  ViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.06.2022.
//

import UIKit

class MainViewController: UITabBarController {
    
    let myGamesVC = MyGamesViewController()
    let gameLibraryVC = GameLibraryViewController()
    let settingsVC = SettingsViewController()
    
    let itemsImages = ["gamecontroller", "folder", "gear"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myGamesNavVC = UINavigationController(rootViewController: myGamesVC)
        myGamesNavVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 30)!]
        myGamesVC.title = "SudokuCo"
        
        let gameLibraryNavVC = UINavigationController(rootViewController: gameLibraryVC)
        gameLibraryNavVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 30)!]
        gameLibraryVC.title = "SudokuCo"
        
        myGamesNavVC.title = "My Games"
        gameLibraryNavVC.title = "Game Library"
        settingsVC.title = "Settings"
        
        self.setViewControllers([myGamesNavVC, gameLibraryNavVC, settingsVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        for i in 0...2 {
            items[i].image = UIImage(systemName: itemsImages[i])
        }
        
        self.tabBar.tintColor = .black
    }
}

