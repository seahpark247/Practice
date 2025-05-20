//
//  ContentView.swift
//  Practice
//
//  Created by Seah Park on 3/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var dream = ""
    @State private var yesterdayDream = ""
    
    var body: some View {
        VStack {
            TextField("Enter your dream today...", text: $dream)
            
            Button("Save") {
                UserDefaults.standard.set(dream, forKey: "savedDream")
            }
            
            Button("Yesterday's Dream") {
                yesterdayDream = UserDefaults.standard.string(forKey: "savedDream") ?? "No dream saved yesterday"
            }
            
            Text(yesterdayDream)
        }
    }
    
}
   
#Preview {
    ContentView()
}
