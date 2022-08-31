//
//  GamesInfoCoding.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 22.06.2022.
//

import Foundation

struct GamesInfoCoding {
    
    let fileManager = FileManager.default
    
    func saveGameInfo(game: SudokuState) {
        let gameName = game.gameName
        let gameFileName = getGameFileName(gameName: gameName)
        
        encode(game: game, gameName: gameName, fileName: gameFileName)
    }
    
    func getGameInfo(gameName: String) -> Any? {
        return decode(gameName: gameName)
    }
    
    private func getGameFileName(gameName: String) -> String {
        var gameFileName = ""
        
        if let gameFile = AllGames().getGameInfoFileByName(gameName: gameName) {
            gameFileName = gameFile
        } else {
            print("Error. There is no Game Info for \(gameName)")
        }
        
        return gameFileName
    }
    
    func isThereUnfinishedGame(gameName: String) -> Bool {
        let fileName = getGameFileName(gameName: gameName)

        let decoder = JSONDecoder()
        
        if let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                let data = try Data(contentsOf: fileURL)
                _ = try decoder.decode(SudokuState.self, from: data)
            } catch {
                print("Error. No Saved Game Info: \(gameName)")
                return false
            }
        }
        return true
    }
    
    private func encode(game: SudokuState, gameName: String, fileName: String) {
        let encoder = JSONEncoder()
        
        if let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                let jsonData = try encoder.encode(game)
                try jsonData.write(to: fileURL)
            } catch {
                print("Error. Game Info Not Saved: \(gameName)")
            }
        }
    }
    
    private func decode(gameName: String) -> Any? {
        let fileName = getGameFileName(gameName: gameName)

        let decoder = JSONDecoder()
        
        if let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                let data = try Data(contentsOf: fileURL)
                return try decoder.decode(SudokuState.self, from: data)
            } catch {
                print("Error. No Saved Game Info: \(gameName)")
            }
        }
        return nil
    }
    
    func deleteGameInfo(gameName: String) {
        let fileName = getGameFileName(gameName: gameName)
        
        if let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                print("Error. No Game Info to Delete: \(gameName)")
            }
        }
    }
}
