//
//  AllGames.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 23.06.2022.
//

import UIKit

struct AllGames {
    private struct Game: Codable {
        let gameName: String
        let gameInfoFile: String
        let gameImageName: String
        let statsFileName: String
        let viewControllerName: String
    }
    
    private let allGames: [String: Game] = [
        "Classic Sudoku": Game(gameName: "Classic Sudoku", gameInfoFile: "ClassicSudokuInfo.json", gameImageName: "Classic Sudoku", statsFileName: "ClassicSudokuStats.json", viewControllerName: "SudokuClassicViewController"),
        "Odd-Even Sudoku": Game(gameName: "Odd-Even Sudoku", gameInfoFile: "OddEvenInfo.json", gameImageName: "Odd-Even Sudoku", statsFileName: "OddEvenSudokuStats.json", viewControllerName: "OddEvenSudokuViewController"),
        "Frame Sudoku": Game(gameName: "Frame Sudoku", gameInfoFile: "FrameSudokuInfo.json", gameImageName: "Frame Sudoku", statsFileName: "FrameSudokuStats.json", viewControllerName: "FrameSudokuViewController"),
        "Dots Sudoku": Game(gameName: "Dots Sudoku", gameInfoFile: "DotsSudokuInfo.json", gameImageName: "Dots Sudoku", statsFileName: "DotsSudokuStats.json", viewControllerName: "DotsSudokuViewController"),
        "Comparison Sudoku": Game(gameName: "Comparison Sudoku", gameInfoFile: "ComparisonSudokuInfo.json", gameImageName: "Comparison Sudoku", statsFileName: "ComparisonSudokuStats.json", viewControllerName: "ComparisonSudokuViewController")]
    
    private var myGamesNames: Set<String> = []
    private let myGamesFile = "myGames.json"
    
    init() {
        loadMyGames()
    }
    
    mutating func addGameToMyGames(gameName: String) {
        loadMyGames()
        myGamesNames.insert(gameName)
        saveGames()
    }
    
    mutating func deleteMyGame(gameName: String) {
        myGamesNames.remove(gameName)
        saveGames()
    }
    
    func getVCNameByGameName(gameName: String) -> String? {
        return allGames[gameName]?.viewControllerName
    }
    
    mutating func getMyGamesNames() -> [String] {
        loadMyGames()
        return Array(myGamesNames)
    }
    
    func getAllGamesNames() -> [String] {
        var games: [String] = []
        
        for i in allGames.keys {
            games.append(i)
        }
        return games
    }
    
    func getGameInfoFileByName(gameName: String) -> String? {
        return allGames[gameName]?.gameInfoFile ?? nil
    }
    
    func getGameImageNameByName(gameName: String) -> String? {
        return allGames[gameName]?.gameImageName ?? nil
    }
    
    func getGameStatsFileNameByName(gameName: String) -> String? {
        return allGames[gameName]?.statsFileName ?? nil
    }
    
    private mutating func loadMyGames() {
        let decoder = JSONDecoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(myGamesFile)
            do {
                let data = try Data(contentsOf: fileURL)
                myGamesNames = try decoder.decode(Set<String>.self, from: data)
            } catch {
                print("Error. No Saved Games in My Games")
            }
        }
    }
    
    private func saveGames() {
        let encoder = JSONEncoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(myGamesFile)
            do {
                let jsonData = try encoder.encode(myGamesNames)
                try jsonData.write(to: fileURL)
            } catch {
                print("Error. My Games Info Not Saved")
            }
        }
    }
}
