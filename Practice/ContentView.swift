//
//  ContentView.swift
//  Practice
//
//  Created by Seah Park on 3/8/25.
//

import SwiftUI

struct TipWarining: ViewModifier {
    var tip: Int
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(tip == 0 ? .red : .primary)
    }
}

extension View {
    func tipWarning(with tip: Int) -> some View {
        modifier(TipWarining(tip: tip))
    }
}

struct ContentView: View {
    @State private var money = 0.0
    @State private var people = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    let tipPercentages = [10, 15, 18, 20, 0]
    
    var totalAmount: Double {
        let tip = money / 100 * Double(tipPercentage)
        return tip + money
    }
    
    var perPerson: Double {
        return totalAmount / Double(people + 2)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(.green.gradient).ignoresSafeArea()
            
                Form {
                    Section("How much money") {
                        TextField("Amount", value: $money, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                        
                        Picker("Number of people", selection: $people) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                        
                    Section("How much tip?") {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }.pickerStyle(.segmented)
                    }
                    
                    Section("Amount for check") {
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).tipWarning(with: tipPercentage)
                    }
                    
                    Section("Amount per person") {
                        Text(perPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                .navigationTitle("WeSplit7")
                .toolbar {
                    if isFocused {
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
            }
        }.scrollContentBackground(.hidden)
    }
}

#Preview {
    ContentView()
}
