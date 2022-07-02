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
    
    var isThereUnfinishedGame: Bool = false
    
    mutating func configureInfoForSaving(gameName: String) {
        self.gameName = gameName
        self.fileName = AllGames().games[gameName]!.gameInfoFile
    }
    
    func encode(game: GeneralSudokuGame) {
        
        let encoder = JSONEncoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                let jsonData = try encoder.encode(game)
                try jsonData.write(to: fileURL)
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
                isThereUnfinishedGame = true
                return try decoder.decode(GeneralSudokuGame.self, from: data)
            } catch {
                print("error")
            }
        }
        return nil
    }
    
    func deleteGameInfo() {
        
        let fileManager = FileManager.default
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                print("delete error")
            }
        }
    }
}
