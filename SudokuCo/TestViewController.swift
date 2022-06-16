//
//  TestViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 16.06.2022.
//

import UIKit

class TestViewController: UIViewController {
    
    let testView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(testView)
        
        testView.backgroundColor = .red
        
        testView.translatesAutoresizingMaskIntoConstraints = false
        testView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        testView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        testView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        testView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    
    }

}
