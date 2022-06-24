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
    
    init(file: String, gameName: String) {
        self.fileName = file
        self.gameName = gameName
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
                    return try decoder.decode(ClassicSudokuGame.self, from: data)
                case "Odd-Even Sudoku":
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
