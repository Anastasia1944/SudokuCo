//
//  SudokuCoTests.swift
//  SudokuCoTests
//
//  Created by Анастасия Горячевская on 19.07.2022.
//

import XCTest
@testable import SudokuCo

class SudokuCoGenerateSudokuTests: XCTestCase {
    
    var generalSudoku: GenerateSudoku!
    var sudokuNumbers: [[Int]]!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        generalSudoku = GenerateSudoku()
        sudokuNumbers = generalSudoku.getSudokuNumbers()
    }

    override func tearDownWithError() throws {
        generalSudoku = nil
        sudokuNumbers = nil
        
        try super.tearDownWithError()
    }
    
    func testGenerationSudokuNumbersSizeCorrection() throws {
        XCTAssertEqual(sudokuNumbers.count, 9)
        
        for i in 0...8 {
            XCTAssertEqual(sudokuNumbers[i].count, 9)
        }
    }
    
    func testGenerationSudokuNumbersNotNil() throws {
        for i in 0...8 {
            for j in 0...8 {
                XCTAssertNotNil(sudokuNumbers[i][j])
            }
        }
    }

    func testGenerationSudokuNumbersNotNull() throws {
        for i in 0...8 {
            for j in 0...8 {
                XCTAssertNotEqual(sudokuNumbers[i][j], 0)
            }
        }
    }
   
    func testGenerationSudokuNumbersDifferentInColumns() throws {
        for i in 0...8 {
            XCTAssertEqual(sudokuNumbers[i].sorted(), [1, 2, 3, 4, 5, 6, 7, 8, 9])
        }
    }
    
    func testGenerationSudokuNumbersDifferentInRows() throws {
        for j in 0...8 {
            var row: [Int] = []
            for i in 0...8 {
                row.append(sudokuNumbers[i][j])
            }
            XCTAssertEqual(row.sorted(), [1, 2, 3, 4, 5, 6, 7, 8, 9])
        }
    }
    
    func testGenerationSudokuNumbersDifferentInAreas() throws {
        for i in 0...2 {
            for j in 0...2 {
                var row: [Int] = []
                for k in 0...2 {
                    for l in 0...2 {
                        row.append(sudokuNumbers[3 * i + k][3 * j + l])
                    }
                }
                XCTAssertEqual(row.sorted(), [1, 2, 3, 4, 5, 6, 7, 8, 9])
            }
        }
    }
}
