//
//  ContentView.swift
//  Practice
//
//  Created by Seah Park on 3/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var memo: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter text", text: $memo)
            
            Button("Save") {
                UserDefaults.standard.set(memo, forKey: "savedMemo")
            }
            
            Button("Road") {
                memo = UserDefaults.standard.string(forKey: "savedMemo") ?? "Saved memo not found"
            }
        }
    }
    
}
   
#Preview {
    ContentView()
}
