//
//  Difficulty levels.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 11.08.2022.
//

import Foundation

enum DifficultyLevels: String,  CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case expert = "Expert"
}
