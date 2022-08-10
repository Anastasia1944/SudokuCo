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
//        self.fileName = AllGames().games[gameName]!.gameInfoFile
        self.fileName = AllGames().getGameInfoFileByName(gameName: gameName) ?? ""
    }
    
    func encode(game: GeneralSudokuGame) {
        
        let encoder = JSONEncoder()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                let jsonData = try encoder.encode(game)
                try jsonData.write(to: fileURL)
            } catch {
                print("Error. Game Info Not Saved: \(gameName)")
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
                print("Error. No Saved Game Info: \(gameName)")
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
                print("Error. No Game Info to Delete: \(gameName)")
            }
        }
    }
}
