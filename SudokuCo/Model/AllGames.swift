//
//  AllGames.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 23.06.2022.
//

import UIKit

struct AllGames {
    struct Game: Codable {
        let gameName: String
        let gameInfoFile: String
        let gameImageName: String
        let statsFileName: String
    }
    
    let games: [String: Game] = [
        "Classic Sudoku": Game(gameName: "Classic Sudoku", gameInfoFile: "ClassicSudokuInfo.json", gameImageName: "Classic Sudoku", statsFileName: "ClassicSudokuStats.json"),
        "Odd-Even Sudoku": Game(gameName: "Odd-Even Sudoku", gameInfoFile: "OddEvenInfo.json", gameImageName: "Odd-Even Sudoku", statsFileName: "OddEvenSudokuStats.json"),
        "Frame Sudoku": Game(gameName: "Frame Sudoku", gameInfoFile: "FrameSudokuInfo.json", gameImageName: "Frame Sudoku", statsFileName: "FrameSudokuStats.json"),
        "Dots Sudoku": Game(gameName: "Dots Sudoku", gameInfoFile: "DotsSudokuInfo.json", gameImageName: "Dots Sudoku", statsFileName: "DotsSudokuStats.json"),
        "Comparison Sudoku": Game(gameName: "Comparison Sudoku", gameInfoFile: "ComparisonSudokuInfo.json", gameImageName: "Comparison Sudoku", statsFileName: "ComparisonSudokuStats.json")]
    
    var myGames: [String: Game] = [:]
    let myGamesFile = "myGames.json"
    
    init() {
        loadMyGames()
    }
    
    func getGamesNames() -> [String] {
        var games: [String] = []
        
        for i in myGames.keys {
            games.append(i)
        }
        return games
    }
    
    mutating func loadMyGames() {
        let decoder = JSONDecoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(myGamesFile)
            do {
                let data = try Data(contentsOf: fileURL)
                myGames = try decoder.decode([String: Game].self, from: data)
            } catch {
                print("error")
            }
        }
    }
    
    func saveGames() {
        let encoder = JSONEncoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(myGamesFile)
            do {
                let jsonData = try encoder.encode(myGames)
                try jsonData.write(to: fileURL)
            } catch {
                print("error")
            }
        }
    }
    
    mutating func deleteMyGame(gameName: String) {
        myGames[gameName] = nil
        saveGames()
    }
}
