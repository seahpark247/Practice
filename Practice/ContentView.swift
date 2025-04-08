//
//  ContentView.swift
//  Practice
//
//  Created by Seah Park on 3/8/25.
//

import SwiftUI

struct tipWarning: ViewModifier {
    var tip: Int
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(tip == 0 ? .red: tip >= 18 ? .blue : .primary)
    }
}

extension View {
    func TipWarningStyle(_ tip: Int) -> some View {
        modifier(tipWarning(tip: tip))
    }
}

struct ContentView: View {
    @State private var money = 0.0
    @State private var people = 2
    @State private var tipPercentage = 18
    @FocusState private var isFocused: Bool
    
    let tipPercentages: [Int] = [10, 15, 18, 20, 0]
    
    var total: Double {
        let tip = money / 100 * Double(tipPercentage)
        return money + tip
    }
    
    var split: Double {
        return total / Double(people + 2)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(.green.gradient).ignoresSafeArea()
                
                Form {
                    Section("How much money"){
                        TextField("Money", value: $money, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                        
                        Picker("Number of people", selection: $people) {
                            ForEach(2..<100){
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    Section("Tip Percentages"){
                        Picker("Tip percentages", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }.pickerStyle(.segmented)
                    }
                    
                    Section("Total"){
                        Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).TipWarningStyle(tipPercentage)
                    }
                    
                    Section("Split"){
                        Text(split, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
            }
            .navigationTitle("WeSplit8")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
    
}
   
#Preview {
    ContentView()
}
