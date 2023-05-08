//
//  GameView.swift
//  XOGame
//
//  Created by Руслан Меланин on 08.05.2023.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack() {
            VStack {
                if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy{ $0 == false} {
                    Text("Ходит первым:")
                }
                HStack {
                    Button(game.player1.name) {
                        game.player1.isCurrent = true
                    }
                    .buttonStyle(PlayerButtonStyle(isCurrent: game.player1.isCurrent))
                    
                    
                    Button(game.player2.name) {
                        game.player2.isCurrent = true
                        if game.gameType == .bot {
                            Task {
                                await game.deviceMove()
                            }
                        }
                    }
                    .buttonStyle(PlayerButtonStyle(isCurrent: game.player2.isCurrent))
                    
                }
                .disabled(game.gameStarted)
                
                VStack {
                    HStack {
                        ForEach(0...2, id: \.self) { index in
                            SquareView(index: index)
                        }
                    }
                    HStack {
                        ForEach(3...5, id: \.self) { index in
                            SquareView(index: index)
                        }
                    }
                    HStack {
                        ForEach(6...8, id: \.self) { index in
                            SquareView(index: index)
                        }
                    }
                }
                .overlay {
                    if game.isThinking {
                        VStack {
                            Text(" Думает... ")
                                .foregroundColor(Color(.systemBackground))
                                .background(Rectangle().fill(Color.primary))
                            ProgressView()
                        }
                    }
                }
                .disabled(game.boardDisabled)
                
                VStack {
                    if game.gameOver {
                        Text("Конец Игры")
                        if game.possibleMoves.isEmpty {
                            Text("Ничья")
                        } else {
                            Text("\(game.currPlayer.name) победил")
                        }
                        
                        Button("Сыграть ещё") {
                            game.reset()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .font(.largeTitle)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Выйти") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
            }
        .navigationTitle("Крест на Нолик")
        .onAppear {
            game.reset()
        }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameService())
    }
}

struct PlayerButtonStyle: ButtonStyle {
    
    let isCurrent: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10).fill(isCurrent ? Color(CGColor(srgbRed: 70/255, green: 28/255, blue: 189/255, alpha: 1.0)) : Color(CGColor(srgbRed: 169/255, green: 110/255, blue: 255/255, alpha: 0.3))))
            .foregroundColor(isCurrent ? .white : .black)
            .buttonStyle(.bordered)

    }
    
}
