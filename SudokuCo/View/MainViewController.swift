//
//  ViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.06.2022.
//

import UIKit

class MainViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainMenuVC = MainMenuViewController()
        
        self.setViewControllers([mainMenuVC], animated: false)
    }
}

