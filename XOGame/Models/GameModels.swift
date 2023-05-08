//
//  GameModels.swift
//  XOGame
//
//  Created by Руслан Меланин on 08.05.2023.
//

import SwiftUI

enum GameType {
    case single, bot, nothing
    
    var description: String {
        switch self {
        case .single:
            return "Была не была..."
        case .bot:
            return "Попробуй сразить свой iPhone."
        case .nothing:
            return ""
        }
    }
}

enum GamePiece: String {
    case o, x
    var image: Image {
        Image(self.rawValue)
    }
}

struct Player {
    let gamePiece: GamePiece
    var name: String
    var moves: [Int] = []
    var isCurrent = false
    var isWinner: Bool {
        for moves in Move.winMoves {
            if moves.allSatisfy(self.moves.contains) {
                return true
            }
        }
        return false
    }
}

enum Move {
    static var all = [1,2,3,4,5,6,7,8,9]

    static var winMoves = [
        [1,2,3],
        [4,5,6],
        [7,8,9],
        [1,4,7],
        [2,5,8],
        [3,6,9],
        [1,5,9],
        [3,5,7],
    ]
}
