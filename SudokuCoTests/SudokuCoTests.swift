//
//  SudokuCoTests.swift
//  SudokuCoTests
//
//  Created by Анастасия Горячевская on 19.07.2022.
//

import XCTest
@testable import SudokuCo

class SudokuCoTests: XCTestCase {
    
    var generalSudoku: GenerateSudoku!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        generalSudoku = GenerateSudoku()
    }

    override func tearDownWithError() throws {
        generalSudoku = nil
        
        try super.tearDownWithError()
    }

    func testExample() throws {
        let nums = generalSudoku.getSudokuNumbers()
        
        for i in 0...8 {
            for j in 0...8 {
                XCTAssertNotEqual(nums[i][j], 0)
            }
        }
    }

    func testPerformanceExample() throws {
        measure {
            generalSudoku.generateSudoku()
        }
    }
}
