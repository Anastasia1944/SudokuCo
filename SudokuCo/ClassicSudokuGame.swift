//
//  ClassicSudokuGame.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 17.06.2022.
//

import UIKit

class ClassicSudokuGame: Codable {
    private var sudokuNumbers: [[Int]] = []
    
    private var originallyOpenedNumbers: [[Int]] = []
    private var openedNumbers: [[Int]] = []
    
    func generateSudoku() {
        let generateSudoku = GenerateSudoku()
        sudokuNumbers = generateSudoku.getSudokuNumbers()
        originallyOpenedNumbers = generateSudoku.getOriginallyOpenedNumbers()
        
        openedNumbers = originallyOpenedNumbers
    }
    
    func fillCell(x: Int, y: Int, value: Int) -> Bool {
        if originallyOpenedNumbers[x][y] == 0 {
            openedNumbers[x][y] = value
            return true
        }
        return false
    }
    
    func deleteCellNumber(x: Int, y: Int) -> Bool {
        if originallyOpenedNumbers[x][y] == 0 {
            openedNumbers[x][y] = 0
            return true
        }
        return false
    }
    
    func getNumberByCoordinates(x: Int, y: Int) -> Int {
        return sudokuNumbers[x][y]
    }
    
    func isNumberOpened(x: Int, y: Int) -> Bool {
        return openedNumbers[x][y] != 0
    }
    
    func getSudokuNumbers() -> [[Int]] {
        return sudokuNumbers
    }
    
    func getSudokuOriginallyOpenedNumbers() -> [[Int]] {
        return originallyOpenedNumbers
    }
    
    func getSudokuOpenedNumbers() -> [[Int]] {
        return openedNumbers
    }
}
