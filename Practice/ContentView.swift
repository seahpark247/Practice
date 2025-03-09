//
//  ContentView.swift
//  Practice
//
//  Created by Seah Park on 3/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US", "Korea"].shuffled()
    @State private var answer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var content = ""
    @State private var showingScore = false

    var body: some View {
        ZStack {
            Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(.indigo.gradient)
            VStack {
                Spacer()
                
                Text("Guess The Flag").font(.title.bold())
                    .foregroundColor(.white)
                
                VStack {
                    Text("Tap the flag of").font(.headline.bold()).foregroundColor(.secondary)
                    Text(countries[answer]).font(.title.bold())
                    
                    VStack(spacing: 20) {
                        ForEach(0..<3) { number in
                            Button {
                                checkAnswer(number)
                            } label: {
                                Image(countries[number])
                                    .clipShape(.capsule).shadow(radius: 5)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(.regularMaterial)
                .cornerRadius(20)
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)").font(.title2.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(content, isPresented: $showingScore) {
            Button("Continue", action: continueGame)
        } message: {
            Text("Your score: \(score)")
        }
        
    }

    func checkAnswer(_ selected: Int) {
        if selected == answer {
            score += 1
            content = "Correct"
        } else {
            content = "Wrong"
        }
        showingScore = true
    }
    
    func continueGame() {
        countries.shuffle()
        answer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
