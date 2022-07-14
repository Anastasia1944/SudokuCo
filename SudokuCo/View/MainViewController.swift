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
    
    let itemsImages = ["gamecontroller", "folder", "chart.bar.doc.horizontal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let myGamesNavVC = UINavigationController(rootViewController: myGamesVC)
        myGamesNavVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blueSys, .font: UIFont.systemFont(ofSize: 24)]
        myGamesVC.title = "SudokuCo"
        
        let gameLibraryNavVC = UINavigationController(rootViewController: gameLibraryVC)
        gameLibraryNavVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blueSys, .font: UIFont.systemFont(ofSize: 24)]
        gameLibraryVC.title = "SudokuCo"
        
        myGamesNavVC.title = "My Games"
        gameLibraryNavVC.title = "Game Library"
        statisticsVC.title = "Statistics"
        
        self.setViewControllers([myGamesNavVC, gameLibraryNavVC, statisticsVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        for i in 0...2 {
            items[i].image = UIImage(systemName: itemsImages[i])
            items[i].badgeColor = .blueSys
        }
        
        self.tabBar.tintColor = .blueSys
        self.tabBar.backgroundColor = .graySys
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        myGamesVC.updateGamesList()
    }
}

