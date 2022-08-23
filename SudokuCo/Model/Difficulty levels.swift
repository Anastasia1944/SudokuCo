//
//  Difficulty levels.swift
//  SudokuCo
//
//  Created by Анастасия Горячевская on 11.08.2022.
//

import Foundation

enum DifficultyLevels: Codable {
    case easy
    case medium
    case hard
    case expert
}

struct DifficultyLevelsStringToEnum {
    
    private let levels: [String] = ["Easy", "Medium", "Hard", "Expert"]
    private let levelsString: [String: DifficultyLevels] = ["Easy": .easy, "Medium": .medium, "Hard": .hard, "Expert": .expert]
    private let levelsEnum: [DifficultyLevels: String] = [.easy: "Easy", .medium: "Medium", .hard: "Hard", .expert: "Expert"]
    
    func getDifficultyLevelsNames() -> [String] {
        return levels
    }
    
    func getDifficultyLevelStringByEnum(level: DifficultyLevels) -> String {
        return levelsEnum[level] ?? ""
    }
    
    func getDifficultyLevelEnumByString(level: String) -> DifficultyLevels {
        return levelsString[level] ?? .easy
    }
}
