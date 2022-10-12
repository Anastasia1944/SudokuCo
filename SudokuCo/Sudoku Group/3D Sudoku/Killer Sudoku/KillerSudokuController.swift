//
//  KillerSudokuController.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 13.08.2022.
//

import Foundation

class KillerSudokuController {
    
    private var killerSudokuAreasOnMatrix: [[Int]] = []
    private var killerSudokuAreas: [Int: Set<Int>] = [:]
    
    private var sudokuNumbers: [[Int]] = []
    
    var diagonalCoordinates: [(Int, Int, Int, Int)] = []
    
    func getKillerSudokuAreas(sudokuNumbers: [[Int]]) -> [[Int]] {
        self.sudokuNumbers = sudokuNumbers
        
        checkSquaresNums()
        
        fillAreasByZeros()
        configureAreas()
        
        return killerSudokuAreasOnMatrix
    }
    
    private func fillAreasByZeros() {
        for _ in Constants.sudokuRange {
            killerSudokuAreasOnMatrix.append([Int](repeating: 0, count: 9))
        }
    }
    
    func checkSquaresNums() {
        for i in 0..<8 {
            for j in 0..<8 {
                for k in i + 1...8 {
                    let coord = sudokuNumbers[k].firstIndex(of: sudokuNumbers[i][j])!
                    
                    if coord > j {
                        if sudokuNumbers[k][j] == sudokuNumbers[i][coord] && (k + 1 == i || k - 1 == i || coord + 1 == j || coord - 1 == j) {
                            self.diagonalCoordinates.append((i, j, k, coord))
                        }
                    }
                }
            }
        }
    }
    
    private func configureAreas() {
        configureDoubleAreas()
        
        configureRemainingCells()
    }
    
    private func configureDoubleAreas() {
        var i = 1
        
        for group in diagonalCoordinates {
            var allCoordinates = [(group.0, group.1), (group.0, group.3), (group.2, group.1), (group.2, group.3)]
            allCoordinates.shuffle()
            _ = allCoordinates.popLast()
            
            for coordinate in allCoordinates {
                let x = coordinate.0
                let y = coordinate.1
                
                if killerSudokuAreasOnMatrix[x][y] == 0 {
                    var availableNeighbors = getAllFreeCellNeighbor(i: x, j: y)
                    availableNeighbors.removeAll(where: { coord in allCoordinates.contains(where: { $0 == coord }) })
                    
                    if let (neighborX, neighborY) = availableNeighbors.randomElement() {
                        self.killerSudokuAreasOnMatrix[x][y] = i
                        self.killerSudokuAreasOnMatrix[neighborX][neighborY] = i

                        killerSudokuAreas[i] = [sudokuNumbers[x][y], sudokuNumbers[neighborX][neighborY]]

                        i += 1
                    }
                }
            }
        }
    }
    
    private func getRandomFreeCellNeighbor(i: Int, j: Int) -> (Int, Int)? {
        let variants = getAllFreeCellNeighbor(i: i, j: j)
        
        return variants.isEmpty ? nil : variants.randomElement()
    }
    
    private func getAllFreeCellNeighbor(i: Int, j: Int) -> [(Int, Int)] {
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
        
        return variants
    }
    
    private func configureRemainingCells() {
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
