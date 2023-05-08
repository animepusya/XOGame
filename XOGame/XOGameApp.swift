//
//  XOGameApp.swift
//  XOGame
//
//  Created by Руслан Меланин on 08.05.2023.
//

import SwiftUI

@main
struct XOGameApp: App {
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game)
        }
    }
}
