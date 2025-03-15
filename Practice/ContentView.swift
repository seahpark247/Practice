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
            .foregroundColor(.black)
            .frame(width: 80, height: 80)
            .background(.black.opacity(0.3))
            .cornerRadius(10)
    }
}

struct RestartButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.white)
            .padding()
            .background(.black.gradient)
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
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(.indigo.gradient).ignoresSafeArea()
            
                VStack {
                    HStack {
                        Spacer()
                        VStack {
                            ForEach(0..<3) { col in
                                HStack {
                                    ForEach(0..<3) { row in
                                        Button {
                                            makeMove(row: row, col: col)
                                        } label: {
                                            // Text(board[row][col] == .x ? "X" : board[row][col] == .o ? "O" : "").cellStyle()! 텍스트칸에 보드 체크해서 엑스 갖고있으면 엑스 넣어주는 식!!
                                            Text(board[row][col] == .x ? "X" : board[row][col] == .o ? "O" : "").cellStyle()
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 30)
                    .background(.regularMaterial)
                    
                    HStack {
                        Button("Restart", action: resetBoard)
                            .buttonStyle()
                        Spacer()
                        Text(checkWinner(player: .x) ? "X is won!" : checkWinner(player: .o) ? "O is won!" : isDraw() ? "Draw!" : "Playing...").statusStyle()
                    }.padding()
                }
            }.navigationTitle("TicTacToe")
        }.scrollContentBackground(.hidden)
    }
    
    func makeMove(row: Int, col: Int) {
        guard board[row][col] == .none && !checkWinner(player: .x) && !checkWinner(player: .o) else {
            return
        }
        
        board[row][col] = currentPlayer
        currentPlayer = currentPlayer == .x ? .o : .x
    }
    
    func checkWinner(player: Player) -> Bool {
        for i in 0..<3 {
            if board[i][0] == player && board[i][1] == player && board[i][2] == player {
                return true
            }
            if board[0][i] == player && board[1][i] == player && board[2][i] == player {
                return true
            }
        }
        
        if board[0][0] == player && board[1][1] == player && board[2][2] == player {
            return true
        }
        if board[0][2] == player && board[1][1] == player && board[2][0] == player {
            return true
        }
        
        return false
    }
    
    func isDraw() -> Bool {
        board.allSatisfy { row in
            row.allSatisfy { $0 != .none }
        }
    }
    
    func resetBoard() {
        board = Array(repeating: Array(repeating: .none, count: 3), count: 3)
        currentPlayer = .x
    }
    
}
   
#Preview {
    ContentView()
}
