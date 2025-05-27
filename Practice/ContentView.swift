//
//  ContentView.swift
//  Practice
//
//  Created by Seah Park on 3/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var toughts = ""
    @State private var yesterday = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("input your toughts today", text: $toughts)
                    HStack {
                        Spacer()
                        Button("Save your toughts") {
                            UserDefaults.standard.set(toughts, forKey: "toughts")
                        }
                    }
                }
                
                Section("saved thoughts") {
                    Button("Check if there is any") {
                        // 유저 디폴트 값 불러오고-> 없으면 ?? 뒤에 비었다고 하기
                        yesterday = UserDefaults.standard.string(forKey: "toughts") ?? "It's empty yet"
                    }
                    Text(yesterday)
                }
            }.navigationTitle("UserDefaults")
        }
    }
    
}
   
#Preview {
    ContentView()
}
