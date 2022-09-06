//
//  AllGames.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 23.06.2022.
//

import UIKit

enum GamesNames: String, Codable{
    case classicSudoku = "Classic Sudoku"
    case oddEvenSudoku = "Odd-Even Sudoku"
    case frameSudoku = "Frame Sudoku"
    case dotsSudoku = "Dots Sudoku"
    case comparisonSudoku = "Comparison Sudoku"
    case sudoku2D = "2D Sudoku"
    case noNeighboursSudoku = "No Neighbors"
    case mathraxSudoku = "Mathrax"
    case killerSudoku = "Killer Sudoku"
}

struct AllGames {
    private struct Game {
        let gameInfoFile: String
        let gameImageName: String
        let statsFileName: String
        let viewControllerName: String
    }
    
    private let allGames: [GamesNames: Game] = [
        .classicSudoku: Game(gameInfoFile: "ClassicSudokuInfo.json",
                             gameImageName: "Classic Sudoku",
                             statsFileName:"ClassicSudokuStats.json",
                             viewControllerName: "SudokuClassicViewController"),
        .oddEvenSudoku: Game(gameInfoFile: "OddEvenInfo.json",
                             gameImageName: "Odd-Even Sudoku",
                             statsFileName: "OddEvenSudokuStats.json",
                             viewControllerName: "OddEvenSudokuViewController"),
        .frameSudoku: Game(gameInfoFile: "FrameSudokuInfo.json",
                           gameImageName: "Frame Sudoku",
                           statsFileName: "FrameSudokuStats.json",
                           viewControllerName: "FrameSudokuViewController"),
        .dotsSudoku: Game(gameInfoFile: "DotsSudokuInfo.json",
                          gameImageName: "Dots Sudoku",
                          statsFileName: "DotsSudokuStats.json",
                          viewControllerName: "DotsSudokuViewController"),
        .comparisonSudoku: Game(gameInfoFile: "ComparisonSudokuInfo.json",
                                gameImageName: "Comparison Sudoku",
                                statsFileName: "ComparisonSudokuStats.json",
                                viewControllerName: "ComparisonSudokuViewController"),
        .sudoku2D: Game(gameInfoFile: "Sudoku2DInfo.json",
                        gameImageName: "2D Sudoku",
                        statsFileName: "Sudoku2DStats.json",
                        viewControllerName: "Sudoku2DViewController"),
        .noNeighboursSudoku: Game(gameInfoFile: "NoNeighborsInfo.json",
                                  gameImageName: "No Neighbors",
                                  statsFileName: "NoNeighborsStats.json",
                                  viewControllerName: "NoNeighborsViewController"),
        .mathraxSudoku: Game(gameInfoFile: "MathraxInfo.json",
                             gameImageName: "Mathrax",
                             statsFileName: "MathraxStats.json",
                             viewControllerName: "MathraxViewController"),
        .killerSudoku: Game(gameInfoFile: "KillerSudokuInfo.json",
                            gameImageName: "Killer Sudoku",
                            statsFileName: "KillerSudokuStats.json",
                            viewControllerName: "KillerSudokuViewController")]
    
    private var myGamesNames: Set<GamesNames> = []
    private let myGamesFile = "myGames.json"
    
    init() {
        loadMyGames()
    }
    
    mutating func addGameToMyGames(gameName: GamesNames) {
        loadMyGames()
        myGamesNames.insert(gameName)
        saveGames()
    }
    
    mutating func deleteMyGame(gameName: GamesNames) {
        myGamesNames.remove(gameName)
        saveGames()
    }
    
    func getVCNameByGameName(gameName: GamesNames) -> String? {
        return allGames[gameName]?.viewControllerName
    }
    
    mutating func getMyGamesNames() -> [GamesNames] {
        loadMyGames()
        return Array(myGamesNames)
    }
    
    func getAllGamesNames() -> [GamesNames] {
        var games: [GamesNames] = []
        
        for i in allGames.keys {
            games.append(i)
        }
        return games
    }
    
    func getGameInfoFileByName(gameName: GamesNames) -> String? {
        return allGames[gameName]?.gameInfoFile ?? nil
    }
    
    func getGameImageNameByName(gameName: GamesNames) -> String? {
        return allGames[gameName]?.gameImageName ?? nil
    }
    
    func getGameStatsFileNameByName(gameName: GamesNames) -> String? {
        return allGames[gameName]?.statsFileName ?? nil
    }
    
    private mutating func loadMyGames() {
        let decoder = JSONDecoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(myGamesFile)
            do {
                let data = try Data(contentsOf: fileURL)
                myGamesNames = try decoder.decode(Set<GamesNames>.self, from: data)
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
