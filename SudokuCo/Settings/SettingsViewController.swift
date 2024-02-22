//
//  SettingsViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 08.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let settignsTableView = UITableView()
    
    var settings: [String] = Settings.allCases.map{ $0.rawValue }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .beige
        view.setBackgroundWaves(waves: 3, color: .lightBlue.withAlphaComponent(0.5))
        
        settignsTableView.dataSource = self
        settignsTableView.delegate = self
        
        navBarSettings()
        configureTableView()
    }
    
    func navBarSettings() {
        navigationItem.title = NSLocalizedString("Settings", comment: "")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightBlue, .font: UIFont.systemFont(ofSize: 24)]
        navigationController?.navigationBar.barTintColor = .beige
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .lightBlue
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func configureTableView() {
        view.addSubview(settignsTableView)
        
        settignsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        settignsTableView.rowHeight = 80
        settignsTableView.backgroundColor = .clear
        
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
        
        cell.backgroundColor = .clear
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(defaults.bool(forKey: settings[indexPath.row]), animated: true)
        switchView.tag = indexPath.row
        switchView.onTintColor = .lightBlue
        switchView.thumbTintColor = .beige
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        cell.textLabel?.text = NSLocalizedString(settings[indexPath.row], comment: "") 
        cell.textLabel?.textColor = .lightBlue
        
        return cell
    }
}
