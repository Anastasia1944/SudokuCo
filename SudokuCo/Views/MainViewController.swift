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
        myGamesNavVC.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .graySys
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blueSys, .font: UIFont.systemFont(ofSize: 32)]
        
        myGamesVC.title = "SudokuCo"
        myGamesNavVC.navigationBar.tintColor = .blueSys
        myGamesNavVC.navigationBar.scrollEdgeAppearance = appearance
        
        let gameLibraryNavVC = UINavigationController(rootViewController: gameLibraryVC)
        gameLibraryNavVC.navigationBar.prefersLargeTitles = true
        
        gameLibraryVC.title = "SudokuCo"
        gameLibraryNavVC.navigationBar.tintColor = .blueSys
        gameLibraryNavVC.navigationBar.scrollEdgeAppearance = appearance
        
        myGamesNavVC.title = "My Games"
        gameLibraryNavVC.title = "Game Library"
        settingsVC.title = "Settings"
        
        self.setViewControllers([myGamesNavVC, gameLibraryNavVC, settingsVC], animated: false)
        
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

