//
//  GameSquare.swift
//  XOGame
//
//  Created by Руслан Меланин on 08.05.2023.
//

import SwiftUI

struct GameSquare {
    var id: Int
    var player: Player?
    
    var image: Image {
        if let player = player {
            return player.gamePiece.image
        } else {
            return Image("none")
        }
    }
    
    static var reset: [GameSquare] {
        var squares = [GameSquare]()
        for index in 1...9 {
            squares.append(GameSquare(id: index))
        }
        return squares
    }
}
