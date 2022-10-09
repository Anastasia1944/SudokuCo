//
//  Sudoku2DProcessor.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 09.10.2022.
//

import Foundation

class Sudoku2DProcessor: GeneralSudokuProcessor {
    
    override func checkAll(sudokuOpenedNums: [[Int]], x: Int, y: Int, num: Int) -> Bool {
        return checkColumn(sudokuOpenedNums: sudokuOpenedNums, x: x, y: y, num: num) &&
        checkRow(sudokuOpenedNums: sudokuOpenedNums, x: x, y: y, num: num)
    }
    
    override func configureOpenedNums(openedNums: Int) {
        var coordinates: [(Int, Int)] = []
        
        var index = 0

        while index != openedNums {
            let pointX = Int.random(in: Constants.sudokuRange)
            let pointY = Int.random(in: Constants.sudokuRange)

            if gameState.originallyOpenedNumbers[pointX][pointY] == 0 && gameState.sudokuNumbers[pointX][pointY] != 0 {
                coordinates.append((pointX, pointY))
                gameState.originallyOpenedNumbers[pointX][pointY] = gameState.sudokuNumbers[pointX][pointY]
                index += 1
            }
        }
        
        addMissingNums(filledCoordinates: coordinates)
        gameState.openedNumbers = gameState.originallyOpenedNumbers
    }
    
    func addMissingNums(filledCoordinates: [(Int, Int)]) {
        var solution = checkIfOneSolution()
        
        var numsAdded = 0
        while solution != nil {
            numsAdded += 1
            let (randomX, randomY) = findCellsDifference(matr1: gameState.sudokuNumbers, matr2: solution!).randomElement() ?? (0, 0)
            gameState.originallyOpenedNumbers[randomX][randomY] = gameState.sudokuNumbers[randomX][randomY]
            solution = checkIfOneSolution()
        }
        
        removePossibleNums(filledCoordinates: filledCoordinates, count: numsAdded)
    }
    
    func findCellsDifference(matr1: [[Int]], matr2: [[Int]]) -> [(Int, Int)] {
        var diff: [(Int, Int)] = []
        for i in Constants.sudokuRange {
            for j in Constants.sudokuRange {
                if matr1[i][j] != matr2[i][j] {
                    diff.append((i, j))
                }
            }
        }
        return diff
    }
    
    func removePossibleNums(filledCoordinates: [(Int, Int)], count: Int) {
        var index = 0
        var filledCoordinates = filledCoordinates
        
        while index != count && !filledCoordinates.isEmpty {
            filledCoordinates.shuffle()
            let (pointX, pointY) = filledCoordinates.popLast() ?? (0, 0)
            
            gameState.originallyOpenedNumbers[pointX][pointY] = 0
            
            let solution = checkIfOneSolution()
            if solution != nil {
                gameState.originallyOpenedNumbers[pointX][pointY] = gameState.sudokuNumbers[pointX][pointY]
            } else {
                index += 1
            }
        }
    }
}
