//
//  GamesStatisticsViewController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.07.2022.
//

import UIKit

class GamesStatisticsViewController: UIViewController {
    
    let statisticsTableView = UITableView()
    
    var myAvaillableGamesNames: [String] = []
    var stats: [GameStatistics] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        statisticsTableView.delegate = self
        statisticsTableView.dataSource = self
        
        statisticsTableView.register(GameStatisticsTableViewCell.self, forCellReuseIdentifier: "statisticsCell")
        
        view.backgroundColor = .white
        
        setTableSettings()
        
        loadStatistics()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadStatistics()
        statisticsTableView.reloadData()
    }
    
    private func loadStatistics() {
        myAvaillableGamesNames = []
        stats = []
        
        let myGamesNames = AllGames().getGamesNames()
        
        for i in 0..<myGamesNames.count {
            var statisticsGameCoding = StatisticGameCoding()
            statisticsGameCoding.configureInfoForSaving(gameName: myGamesNames[i])
            
            if let s = statisticsGameCoding.decode() {
                myAvaillableGamesNames.append(myGamesNames[i])
                stats.append(s)
            }
        }
    }
    
    func setTableSettings() {
        view.addSubview(statisticsTableView)
        
        statisticsTableView.separatorStyle = .none
        
        statisticsTableView.translatesAutoresizingMaskIntoConstraints = false
        statisticsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        statisticsTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        statisticsTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        statisticsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
