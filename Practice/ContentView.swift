//
//  ContentView.swift
//  Practice
//
//  Created by Seah Park on 3/8/25.
//

import SwiftUI

enum Player {
    case x, o, none
}

struct Cell: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50))
            .frame(width: 80, height: 80)
            .foregroundColor(.black)
            .background(.gray.opacity(0.3))
            .cornerRadius(10)
    }
}

struct RestartButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding()
            .background(.black.gradient)
            .foregroundStyle(.white)
            .cornerRadius(10)
    }
}

struct StatusText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func cellStyle() -> some View {
        modifier(Cell())
    }
    
    func buttonStyle() -> some View {
        modifier(RestartButton())
    }
    
    func statusStyle() -> some View {
        modifier(StatusText())
    }
}

struct ContentView: View {
    @State private var board: [[Player]] = Array(repeating: Array(repeating: .none, count: 3), count: 3)
    @State private var currentPlayer: Player = .x
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(.indigo.gradient)
                    .ignoresSafeArea()
                
                VStack() {
                    HStack{
                        Spacer()
                        VStack {
                            ForEach(0..<3) { row in
                                HStack {
                                    ForEach(0..<3) { col in
                                        Button {
                                            makeMove(row: row, col: col)
                                        } label: {
                                            Text(board[row][col] == .x ? "X" : board[row][col] == .o ? "O" : "").cellStyle()
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        Spacer()
                    }
                    .padding()
                    .background(.regularMaterial)
                    
                    HStack {
                        Button("Restart") {
                            resetGame()
                        }.buttonStyle()
                        
                        Spacer()
                        
                        Text(checkWin(player: .x) ? "X is won!" : checkWin(player: .o) ? "O is won!" : isDraw() ? "Draw!" : "playing...").statusStyle()
                    }.padding()
                }.navigationTitle("TicTacToe")
            }
        }.scrollContentBackground(.hidden)
    }
    
    func makeMove(row: Int, col: Int) {
        guard !checkWin(player: .x) && !checkWin(player: .o) && !isDraw() else { return }
        guard board[row][col] == .none else { return }
        
        board[row][col] = currentPlayer
        currentPlayer = (currentPlayer == .x) ? .o : .x
    }
    
    func checkWin(player: Player) -> Bool {
        for i in 0..<3 {
            if board[i][0] == player && board [i][1] == player && board[i][2] == player {
                return true
            }
            if board[0][i] == player && board[1][i] == player && board[2][i] == player {
                return true
            }
        }
        
        if board[0][0] == player && board[1][1] == player && board[2][2] == player {
            return true
        }
        if board[2][0] == player && board[1][1] == player && board[0][2] == player {
            return true
        }
        
        return false
    }
    
    func isDraw() -> Bool {
        return board.allSatisfy { row in
            row.allSatisfy { $0 != .none }
        }
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: .none, count: 3), count: 3)
        currentPlayer = .x
    }
    
}
   

#Preview {
    ContentView()
}
