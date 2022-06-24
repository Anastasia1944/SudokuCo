//
//  GamesInfoCoding.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 22.06.2022.
//

import Foundation

struct GamesInfoCoding {
    var fileName = ""
    var gameName = ""
    
    var game: Any?
    
    var isThereUnfinishedGame: Bool = false
    
    init(gameName: String) {
        self.gameName = gameName
        self.fileName = AllGames().games[gameName]!.gameInfoFile
    }
    
    func encode(game: Any) {
        let encoder = JSONEncoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                switch gameName {
                case "Classic Sudoku":
                    let jsonData = try encoder.encode(game as! ClassicSudokuGame)
                    try jsonData.write(to: fileURL)
                case "Odd-Even Sudoku":
                    let jsonData = try encoder.encode(game as! OddEvenSudokuGame)
                    try jsonData.write(to: fileURL)
                default: return
                }
            } catch {
                print("error")
            }
        }
    }
    
    mutating func decode() -> Any? {
        let decoder = JSONDecoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                let data = try Data(contentsOf: fileURL)
                switch gameName {
                case "Classic Sudoku":
                    isThereUnfinishedGame = true
                    return try decoder.decode(ClassicSudokuGame.self, from: data)
                case "Odd-Even Sudoku":
                    isThereUnfinishedGame = true
                    return try decoder.decode(OddEvenSudokuGame.self, from: data)
                default: return nil
                }
            } catch {
                print("error")
            }
        }
        return nil
    }
}
