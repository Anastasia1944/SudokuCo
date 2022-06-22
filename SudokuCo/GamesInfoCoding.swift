//
//  GamesInfoCoding.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 22.06.2022.
//

import Foundation

struct GamesInfoCoding {
    let fileName = "ClassicSudokuInfo.json"
    
    var classicSudoku = ClassicSudokuGame()
    
    func encode() {
        let encoder = JSONEncoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                let jsonData = try encoder.encode(classicSudoku)
                try jsonData.write(to: fileURL)
            } catch {
                print("error")
            }
        }
    }
    
    mutating func decode() {
        let decoder = JSONDecoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                let data = try Data(contentsOf: fileURL)
                classicSudoku = try decoder.decode(ClassicSudokuGame.self, from: data)
            } catch {
                print("error")
            }
        }
    }
}
