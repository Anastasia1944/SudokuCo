//
//  SudokuAction.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 24.06.2022.
//

import Foundation

struct SudokuAction: Codable {
    let xCell: Int
    let yCell: Int
    let lastNumber: Int
    var note: Bool = false
    var isAddNote: Bool = true
}
