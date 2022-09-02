//
//  GameInfos.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import Foundation

struct GameInfos {
    
    private var gameInfos: [String: String] = ["Classic Sudoku": NSLocalizedString("Classic Sudoku Info", comment: ""),
                                                "Comparison Sudoku": NSLocalizedString("Comparison Sudoku Info", comment: ""),
                                                "Dots Sudoku": NSLocalizedString("Dots Sudoku Info", comment: ""),
                                                "Frame Sudoku": NSLocalizedString("Frame Sudoku Info", comment: ""),
                                                "Odd-Even Sudoku": NSLocalizedString("Odd-Even Sudoku Info", comment: ""),
                                                "2D Sudoku": NSLocalizedString("2D Sudoku Info", comment: ""),
                                                "No Neighbors": NSLocalizedString("No Neighbors Info", comment: ""),
                                                "Mathrax": NSLocalizedString("Mathrax Info", comment: ""),
                                                "Killer Sudoku": NSLocalizedString("Killer Sudoku Info", comment: "")]
    
    func getInfoByGameName(_ gameName: String) -> String {
        return gameInfos[gameName] ?? "There are no Game Info now"
    }
}
