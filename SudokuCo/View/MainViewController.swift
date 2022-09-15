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
    let statisticsVC = GamesStatisticsViewController()
    
    let itemsImages = ["gamecontroller", "folder", "text.badge.star"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myGamesNavVC = UINavigationController(rootViewController: myGamesVC)
        myGamesNavVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blueSys, .font: UIFont.systemFont(ofSize: 24)]
        myGamesNavVC.navigationBar.backgroundColor = .whiteSys
        myGamesVC.title = "SudokuCo"
        
        let gameLibraryNavVC = UINavigationController(rootViewController: gameLibraryVC)
        gameLibraryNavVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blueSys, .font: UIFont.systemFont(ofSize: 24)]
        gameLibraryVC.title = "SudokuCo"
        
        myGamesNavVC.title = NSLocalizedString("My Games", comment: "")
        gameLibraryNavVC.title = NSLocalizedString("Game Library", comment: "")
        statisticsVC.title = NSLocalizedString("Statistics", comment: "")
        
        self.setViewControllers([myGamesNavVC, gameLibraryNavVC, statisticsVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        for i in 0...2 {
            items[i].image = UIImage(systemName: itemsImages[i])
            items[i].badgeColor = .blueSys
        }
        
        self.tabBar.tintColor = .blueSys
        self.tabBar.backgroundColor = .whiteSys
    }
}

