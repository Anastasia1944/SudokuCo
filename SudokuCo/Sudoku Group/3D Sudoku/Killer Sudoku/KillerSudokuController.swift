//
//  KillerSudokuController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 13.08.2022.
//

import Foundation

struct KillerSudokuController {
    
    private var killerSudokuAreasOnMatrix: [[Int]] = []
    private var killerSudokuAreas: [Int: Set<Int>] = [:]
    
    private var sudokuNumbers: [[Int]] = []
    
    mutating func getKillerSudokuAreas(sudokuNumbers: [[Int]]) -> [[Int]] {
        self.sudokuNumbers = sudokuNumbers
        
        fillAreasByZeros()
        configureAreas()
        
        return killerSudokuAreasOnMatrix
    }
    
    private mutating func fillAreasByZeros() {
        for _ in Constants.sudokuRange {
            killerSudokuAreasOnMatrix.append([Int](repeating: 0, count: 9))
        }
    }
    
    private mutating func configureAreas() {
        configureDoubleAreas()
        
        configureRemainingCells()
    }
    
    private mutating func configureDoubleAreas() {
        var x = 1
        
        while x != 26 {
            let i = Int.random(in: Constants.sudokuRange)
            let j = Int.random(in: Constants.sudokuRange)
            
            if killerSudokuAreasOnMatrix[i][j] == 0 {
                if let (i1, j1) = getRandomFreeCellNeighbor(i: i, j: j) {
                    self.killerSudokuAreasOnMatrix[i][j] = x
                    self.killerSudokuAreasOnMatrix[i1][j1] = x
                    
                    killerSudokuAreas[x] = [sudokuNumbers[i][j], sudokuNumbers[i1][j1]]
                    
                    x += 1
                }
            }
        }
    }
    
    private func getRandomFreeCellNeighbor(i: Int, j: Int) -> (Int, Int)? {
        var variants: [(Int, Int)] = []
        
        if i != 0 && killerSudokuAreasOnMatrix[i - 1][j] == 0 {
            variants.append((i - 1, j))
        }
        
        if i != 8 && killerSudokuAreasOnMatrix[i + 1][j] == 0 {
            variants.append((i + 1, j))
        }
        
        if j != 0 && killerSudokuAreasOnMatrix[i][j - 1] == 0 {
            variants.append((i, j - 1))
        }
        
        if j != 8 && killerSudokuAreasOnMatrix[i][j + 1] == 0 {
            variants.append((i, j + 1))
        }
        
        return variants.isEmpty ? nil : variants.randomElement()
    }
    
    private mutating func configureRemainingCells() {
        var x = 26
        
        for i in Constants.sudokuRange {
            for j in Constants.sudokuRange {
                if killerSudokuAreasOnMatrix[i][j] == 0 {
                    if let (i1, j1, area) = getRandomNeighborAvailableArea(i: i, j: j) {
                        if area != 0 {
                            killerSudokuAreasOnMatrix[i][j] = area
                            killerSudokuAreas[area]?.insert(sudokuNumbers[i][j])
                        } else {
                            killerSudokuAreasOnMatrix[i][j] =  x
                            killerSudokuAreasOnMatrix[i1][j1] = x
                            
                            killerSudokuAreas[x] = [sudokuNumbers[i][j], sudokuNumbers[i1][j1]]
                            
                            x += 1
                        }
                    }
                }
            }
        }
    }
    
    private func getRandomNeighborAvailableArea(i: Int, j: Int) -> (Int, Int, Int)? {
        var variants: [(Int, Int, Int)] = []
        
        if i != 0 {
            let neighborAreaNumber = killerSudokuAreasOnMatrix[i - 1][j]
            
            if neighborAreaNumber == 0 {
                variants.append((i - 1, j, 0))
            } else {
                if !killerSudokuAreas[neighborAreaNumber]!.contains(sudokuNumbers[i][j]) {
                    variants.append((i - 1, j, neighborAreaNumber))
                }
            }
        }
        
        if i != 8 {
            let neighborAreaNumber = killerSudokuAreasOnMatrix[i + 1][j]
            
            if neighborAreaNumber == 0 {
                variants.append((i + 1, j, 0))
            } else {
                if !killerSudokuAreas[neighborAreaNumber]!.contains(sudokuNumbers[i][j]) {
                    variants.append((i + 1, j, neighborAreaNumber))
                }
            }
        }
        
        if j != 0 {
            let neighborAreaNumber = killerSudokuAreasOnMatrix[i][j - 1]
            
            if neighborAreaNumber == 0 {
                variants.append((i, j - 1, 0))
            } else {
                if !killerSudokuAreas[neighborAreaNumber]!.contains(sudokuNumbers[i][j]) {
                    variants.append((i, j - 1, neighborAreaNumber))
                }
            }
        }
        
        if j != 8 {
            let neighborAreaNumber = killerSudokuAreasOnMatrix[i][j + 1]
            
            if neighborAreaNumber == 0 {
                variants.append((i, j + 1, 0))
            } else {
                if !killerSudokuAreas[neighborAreaNumber]!.contains(sudokuNumbers[i][j]) {
                    variants.append((i, j + 1, neighborAreaNumber))
                }
            }
        }
        
        return variants.isEmpty ? nil : variants.randomElement()
    }
    
    func getAreasSum() -> [[Int]] {
        var areaNums: [[Int]] = []
        
        for _ in Constants.sudokuRange {
            areaNums.append([Int](repeating: 0, count: 9))
        }
        
        var markedAreas: Set<Int> = []
        
        for i in Constants.sudokuRange {
            for j in Constants.sudokuRange {
                let areaNum = killerSudokuAreasOnMatrix[i][j]
                
                if !markedAreas.contains(areaNum) {
                    markedAreas.insert(areaNum)
                    areaNums[i][j] = Array(killerSudokuAreas[areaNum]!).reduce(0, +)
                }
            }
        }
        
        return areaNums
    }
}
