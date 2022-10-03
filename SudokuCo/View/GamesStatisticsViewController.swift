//
//  GamesStatisticsViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.07.2022.
//

import UIKit

class GamesStatisticsViewController: UIViewController {
    
    private var statisticsLevelsSegmentedController = UISegmentedControl()
    private let statisticsTableView = UITableView()
    
    private var myAvaillableGamesNames: [GamesNames] = []
    private var stats: [GameStatistics] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .beige
        
        statisticsTableView.delegate = self
        statisticsTableView.dataSource = self
        
        statisticsTableView.register(GameStatisticsTableViewCell.self, forCellReuseIdentifier: "statisticsCell")
        
        navBarSettings()
        
        let levels = DifficultyLevels.allCases.map{ NSLocalizedString($0.rawValue, comment: "") }
        statisticsLevelsSegmentedController = UISegmentedControl(items: levels)

        setSegmenteControlSettings()
        setTableSettings()
    }
    
    func navBarSettings() {
        navigationItem.title = "SudokuCo"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightBlue, .font: UIFont.systemFont(ofSize: 24)]
        navigationController?.navigationBar.barTintColor = .beige
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .lightBlue
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadInfo()
    }
    
    private func setSegmenteControlSettings() {
        view.addSubview(statisticsLevelsSegmentedController)
        
        statisticsLevelsSegmentedController.selectedSegmentIndex = 0
        statisticsLevelsSegmentedController.backgroundColor = .lightBlue
        statisticsLevelsSegmentedController.selectedSegmentTintColor = .beige
        statisticsLevelsSegmentedController.setTitleTextAttributes([.foregroundColor: UIColor.beige], for: .normal)
        statisticsLevelsSegmentedController.setTitleTextAttributes([.foregroundColor: UIColor.lightBlue], for: .selected)
        
        statisticsLevelsSegmentedController.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        statisticsLevelsSegmentedController.translatesAutoresizingMaskIntoConstraints = false
        statisticsLevelsSegmentedController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        statisticsLevelsSegmentedController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        statisticsLevelsSegmentedController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        statisticsLevelsSegmentedController.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!)
    {
        reloadInfo()
    }
    
    private func loadStatistics(level: DifficultyLevels) {
        myAvaillableGamesNames = []
        stats = []
    
        var allGames = AllGames()
        let myGamesNames = allGames.getMyGamesNames()
        
        let statisticsGameCoding = StatisticGameCoding()
        
        for i in 0..<myGamesNames.count {
            if var s = statisticsGameCoding.getStatistics(gameName: myGamesNames[i], gameLevel: level) {
                myAvaillableGamesNames.append(myGamesNames[i])
                s.gameName = myGamesNames[i]
                stats.append(s)
            }
        }
        myAvaillableGamesNames = myAvaillableGamesNames.sorted(by: {$0.rawValue < $1.rawValue})
        stats = stats.sorted(by: { $0.gameName.rawValue < $1.gameName.rawValue })
    }
    
    private func setTableSettings() {
        view.addSubview(statisticsTableView)
        
        statisticsTableView.backgroundColor = .clear
        statisticsTableView.separatorStyle = .none
        statisticsTableView.allowsSelection = false
        
        statisticsTableView.translatesAutoresizingMaskIntoConstraints = false
        statisticsTableView.topAnchor.constraint(equalTo: statisticsLevelsSegmentedController.bottomAnchor).isActive = true
        statisticsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        statisticsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        statisticsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func reloadInfo() {
        let gameLevelEnum = DifficultyLevels.allCases[statisticsLevelsSegmentedController.selectedSegmentIndex]
        
        loadStatistics(level: gameLevelEnum)
        statisticsTableView.reloadData()
    }
}

extension GamesStatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stats.count == 0 {
            tableView.setEmptyView(mainText: NSLocalizedString("No Statistics", comment: ""), addText: NSLocalizedString("Play Some Games", comment: ""))
        } else {
            tableView.restore()
        }
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let statisticsCell = tableView.dequeueReusableCell(withIdentifier: "statisticsCell", for: indexPath) as! GameStatisticsTableViewCell
        
        statisticsCell.gameStatistics = stats[indexPath.row]
        
        statisticsCell.configureCell()
        
        return statisticsCell
    }
}
