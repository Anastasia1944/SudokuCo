//
//  GameInfos.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import Foundation

struct GameInfos {
    
    private var gameInfos: [GamesNames: String] = [.classicSudoku: NSLocalizedString("Classic Sudoku Info", comment: ""),
                                                   .comparisonSudoku: NSLocalizedString("Comparison Sudoku Info", comment: ""),
                                                   .dotsSudoku: NSLocalizedString("Dots Sudoku Info", comment: ""),
                                                   .frameSudoku: NSLocalizedString("Frame Sudoku Info", comment: ""),
                                                   .oddEvenSudoku: NSLocalizedString("Odd-Even Sudoku Info", comment: ""),
                                                   .sudoku2D: NSLocalizedString("2D Sudoku Info", comment: ""),
                                                   .noNeighboursSudoku: NSLocalizedString("No Neighbors Info", comment: ""),
                                                   .mathraxSudoku: NSLocalizedString("Mathrax Info", comment: ""),
                                                   .killerSudoku: NSLocalizedString("Killer Sudoku Info", comment: ""),
                                                   .easyAsABC: NSLocalizedString("Easy As ABC Info", comment: "")]
    
    func getInfoByGameName(_ gameName: GamesNames) -> String {
        return gameInfos[gameName] ?? "There are no Game Info now"
    }
}
