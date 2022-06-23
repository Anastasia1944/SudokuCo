//
//  AllGames.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 23.06.2022.
//

import UIKit

struct AllGames {
    struct Game {
        let nameViewController: String
        let gameName: String
        let gameInfoCodable: String
        let gameInfoFile: String
    }
    
    let games: [Game] = [Game(nameViewController: "SudokuClassicViewController", gameName: "Classic Sudoku", gameInfoCodable: "ClassicSudokuGame", gameInfoFile: "ClassicSudokuInfo.json")]
}
