//
//  SettingsViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 14.06.2022.
//

import UIKit

struct Setting {
    
    var group: String
    
    var groupTexts: [String]
    
    init(group: String, texts: [String]) {
        self.groupTexts = texts
        self.group = group
    }
}


class SettingsViewController: UIViewController {
    
    let settingsTableView = UITableView()
    
    var settingsArray: [Setting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableSettings()
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        settingsArray.append(Setting(group: "Additional", texts: ["Help", "About"]))
    }
    
    func tableSettings() {
        
        view.addSubview(settingsTableView)
        
        settingsTableView.rowHeight = 60
        
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        settingsTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        settingsTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray[section].groupTexts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = settingsArray[indexPath.section].groupTexts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsArray[section].group
    }
}
