//
//  SudokuClassicController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 07.10.2022.
//

import Foundation

class SudokuClassicProcessor: GeneralSudokuProcessor {
    
    override func configureOpenedNums(openedNums: Int) {
        gameState.originallyOpenedNumbers = gameState.sudokuNumbers
        
        var coordinates: [(Int, Int)] = Constants.sudokuRange.flatMap{ coordinateX in
            Constants.sudokuRange.map{ coordinateY in (coordinateX, coordinateY) }
        }
        
        var remainingNumsCount = N * N
        
        var index = N * N - openedNums
        while index != 0 && !coordinates.isEmpty {
            coordinates.shuffle()
            let (pointX, pointY) = coordinates.popLast() ?? (0, 0)

            if removeNumIfNeeded(x: pointX, y: pointY) {
                index -= 1
                remainingNumsCount -= 1
            }
        }
        
        gameState.openedNumbers = gameState.originallyOpenedNumbers
    }
    
    func removeNumIfNeeded(x: Int, y: Int) -> Bool {
        if gameState.originallyOpenedNumbers[x][y] != 0 {
            gameState.originallyOpenedNumbers[x][y] = 0

            let solution = super.checkIfOneSolution()
            if solution != nil {
                gameState.originallyOpenedNumbers[x][y] = gameState.sudokuNumbers[x][y]
            } else {
                return true
            }
        }
        return false
    }
}
