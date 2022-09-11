//
//  SettingsViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 08.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let settignsTableView = UITableView()
    
    var settings: [String] = Settings.allCases.map{ NSLocalizedString($0.rawValue, comment: "") }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .whiteSys
        
        settignsTableView.dataSource = self
        settignsTableView.delegate = self
        
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(settignsTableView)
        
        settignsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        settignsTableView.rowHeight = 60
        
        settignsTableView.translatesAutoresizingMaskIntoConstraints = false
        settignsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        settignsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        settignsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        settignsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        defaults.set(sender.isOn, forKey: settings[sender.tag])
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(defaults.bool(forKey: settings[indexPath.row]), animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        cell.textLabel?.text = settings[indexPath.row]
        
        return cell
    }
}
