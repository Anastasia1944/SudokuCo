//
//  SudokuClassicViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 15.06.2022.
//

import UIKit

class SudokuClassicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewSettings()
    }
    
    func setViewSettings() {
        view.backgroundColor = .white
        
        let grid = SudokuGrid()
        self.view.addSubview(grid)
    }
}
