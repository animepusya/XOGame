//
//  StartView.swift
//  XOGame
//
//  Created by Руслан Меланин on 08.05.2023.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var game: GameService
    @State private var gameType:GameType = .nothing
    @State private var playerName1 = ""
    @State private var playerName2 = ""
    @FocusState private var focus: Bool
    @State private var startGame = false
    
    var body: some View {
        
        NavigationStack() {
            
            VStack {
                
                Picker("Режим игры", selection: $gameType) {
                    Text("Выбери режим игры").tag(GameType.nothing)
                    Text("Вместе с другом").tag(GameType.single)
                    Text("Уничтожить бота").tag(GameType.bot)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10,style: .continuous).stroke(lineWidth: 2))
                
                Text(gameType.description)
                    .padding()
                
                VStack {
                    switch gameType {
                    case .single:
                        VStack {
                            TextField("Имя друга врага", text: $playerName1)
                            TextField("Имя врага друга", text: $playerName2)
                        }
                    case .bot:
                        TextField("Твоё имя", text: $playerName1)
                    case .nothing:
                        EmptyView()
                    }
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                .focused($focus)
                .frame(width: 350)
                
                Button("Играть") {
                    game.setupGame(gameType: gameType, player1Name: playerName1, player2Name: playerName2)
                    focus = false
                    startGame.toggle()
                }
                .buttonStyle(.borderedProminent)
                .disabled(gameType == .bot && playerName1.isEmpty ||
                          gameType == .nothing ||
                          gameType == .single && (playerName1.isEmpty || playerName2.isEmpty)
                )
                Image("LaunchScreen")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Крест на Нолик")
            .fullScreenCover(isPresented: $startGame) {
                GameView()
            }
            
        }
        
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(GameService())
    }
}
