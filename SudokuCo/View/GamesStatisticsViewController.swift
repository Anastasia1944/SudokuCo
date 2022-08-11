//
//  GamesStatisticsViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.07.2022.
//

import UIKit

class GamesStatisticsViewController: UIViewController {
    
    static private let levelsStringArray: [String] =  ["Easy", "Medium", "Hard", "Expert"]
    
    let statisticsLevelsSegmentedController = UISegmentedControl (items: levelsStringArray)
    
    let statisticsTableView = UITableView()
    
    var myAvaillableGamesNames: [String] = []
    var stats: [GameStatistics] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        statisticsTableView.delegate = self
        statisticsTableView.dataSource = self
        
        statisticsTableView.register(GameStatisticsTableViewCell.self, forCellReuseIdentifier: "statisticsCell")
        
        setSegmenteControlSettings()
        setTableSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let gameLevelString = GamesStatisticsViewController.levelsStringArray[statisticsLevelsSegmentedController.selectedSegmentIndex]
        let gameLevelEnum = DifficultyLevelsStringToEnum().getDifficultyLevelEnumByString(level: gameLevelString)
        
        loadStatistics(level: gameLevelEnum)
        statisticsTableView.reloadData()
    }
    
    private func setSegmenteControlSettings() {
        
        view.addSubview(statisticsLevelsSegmentedController)
        
        statisticsLevelsSegmentedController.selectedSegmentIndex = 0
        
        statisticsLevelsSegmentedController.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        statisticsLevelsSegmentedController.translatesAutoresizingMaskIntoConstraints = false
        statisticsLevelsSegmentedController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        statisticsLevelsSegmentedController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        statisticsLevelsSegmentedController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        statisticsLevelsSegmentedController.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!)
    {
        
        let gameLevelString = GamesStatisticsViewController.levelsStringArray[sender.selectedSegmentIndex]
        let gameLevelEnum = DifficultyLevelsStringToEnum().getDifficultyLevelEnumByString(level: gameLevelString)
        
        loadStatistics(level: gameLevelEnum)
        statisticsTableView.reloadData()
    }
    
    private func loadStatistics(level: DifficultyLevels) {
        myAvaillableGamesNames = []
        stats = []
        
//        let myGamesNames = AllGames().getGamesNames()
        var allGames = AllGames()
        let myGamesNames = allGames.getMyGamesNames()
        
        let statisticsGameCoding = StatisticGameCoding()
        
        for i in 0..<myGamesNames.count {
//            statisticsGameCoding.configureInfoForSaving(gameName: myGamesNames[i], level: level)
            
//            if var s = statisticsGameCoding.decode() {
            if var s = statisticsGameCoding.getStatistics(gameName: myGamesNames[i], gameLevel: level) {
                myAvaillableGamesNames.append(myGamesNames[i])
                s.gameName = myGamesNames[i]
                stats.append(s)
            }
        }
        myAvaillableGamesNames = myAvaillableGamesNames.sorted()
        stats = stats.sorted(by: { $0.gameName < $1.gameName })
    }
    
    func setTableSettings() {
        view.addSubview(statisticsTableView)
        
        statisticsTableView.separatorStyle = .none
        statisticsTableView.allowsSelection = false
        
        statisticsTableView.translatesAutoresizingMaskIntoConstraints = false
        statisticsTableView.topAnchor.constraint(equalTo: statisticsLevelsSegmentedController.bottomAnchor).isActive = true
        statisticsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        statisticsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        statisticsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func intTimeToString(time: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: TimeInterval(time))!
    }
}

extension GamesStatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stats.count == 0 {
            tableView.setEmptyView(mainText: "There are no statistics now", addText: "Play some games at My Games")
        } else {
            tableView.restore()
        }
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let statisticsCell = tableView.dequeueReusableCell(withIdentifier: "statisticsCell", for: indexPath) as! GameStatisticsTableViewCell
        
        let gameName = myAvaillableGamesNames[indexPath.row]
        let gamesWon = stats[indexPath.row].winGamesCount
        
        let winRatePercentage = Double(stats[indexPath.row].winGamesCount) / Double(stats[indexPath.row].allgamesCount) * 100
        let winRate = String(round(winRatePercentage * 10) / 10) + "%"
        
        var time = 0
        
        for i in 0..<stats[indexPath.row].times.count {
            time += stats[indexPath.row].times[i]
        }
        
        let averageTime = intTimeToString(time: time / stats[indexPath.row].allgamesCount)
        
        statisticsCell.configureCell(gameName: gameName, gamesWon: gamesWon, winRate: winRate, averageTime: averageTime)
        
        return statisticsCell
    }
}
