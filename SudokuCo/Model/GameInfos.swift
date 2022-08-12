//
//  GameInfos.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 12.08.2022.
//

import Foundation

struct GameInfos {
    
    private let gameInfos: [String: String] = ["Classic Sudoku": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once.",
                                               "Comparison Sudoku": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once. Also it has comparison signs (“>” and “<”), showing the ratio of numbers in adjacent cells.",
                                               "Dots Sudoku" : "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once. If in neighboring cells one number is twice as large as the other, there is a black dot between them. If the numbers in neighboring cells differ by one, the dot between them is white.",
                                               "Frame Sudoku": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once. This variant of Sudoku contains numbers around the grid instead of the usual task. Each of the numbers represents the sum of the nearest three digits in a row or column.",
                                               "Odd-Even Sudoku": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row, vertical column, square block each number occurs only once. In this variant of Sudoku, information is given about the evenness or oddness of the numbers in the cells. Cells with odd numbers are marked with circles.",
                                               "2D Sudoku": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row and vertical column each number occurs only once. In this puzzle, unlike the classic Sudoku, there is no block limit.",
                                               "No Neighbors": "Task - to fill empty cells with numbers from 1 to 9 in such way: in each horizontal row and vertical column each number occurs only once. In neighboring cells, separated by a bold line, there are consecutive numbers. Numbers without a line between them cannot be consecutive."]
    
    func getInfoByGameName(_ gameName: String) -> String {
        return gameInfos[gameName] ?? "There are no Game Info now"
    }
}
