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
    }
    
    let games: [String: Game] = [
        "Classic Sudoku": Game(gameName: "Classic Sudoku", gameInfoFile: "ClassicSudokuInfo.json", gameImageName: "Classic Sudoku"),
        "Odd-Even Sudoku": Game(gameName: "Odd-Even Sudoku", gameInfoFile: "OddEvenInfo.json", gameImageName: "Odd-Even Sudoku"),
        "Frame Sudoku": Game(gameName: "Frame Sudoku", gameInfoFile: "FrameSudokuInfo.json", gameImageName: "Frame Sudoku"),
        "Dots Sudoku": Game(gameName: "Dots Sudoku", gameInfoFile: "DotsSudokuInfo.json", gameImageName: "Dots Sudoku"),
        "Comparison Sudoku": Game(gameName: "Comparison Sudoku", gameInfoFile: "ComparisonSudokuInfo.json", gameImageName: "Comparison Sudoku")]
    
    var myGames: [String: Game] = [:]
    let myGamesFile = "myGames.json"
    
    init() {
        loadMyGames()
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
