//
//  ContentView.swift
//  Practice
//
//  Created by Seah Park on 3/8/25.
//

import SwiftUI

struct BlueButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
            .padding()
            .background(.blue)
    }
}

struct CapsuleButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
            .padding()
            .background(.yellow)
            .clipShape(.capsule)
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(BlueButton())
    }
    
    func capsuleStyle() -> some View {
        modifier(CapsuleButton())
    }
}

struct ContentView: View {
    
    var body: some View {
        Text("dd")
    }
    
}
   
#Preview {
    ContentView()
}
