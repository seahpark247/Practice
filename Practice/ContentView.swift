//
//  ContentView.swift
//  Practice
//
//  Created by Seah Park on 3/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var money = 0.0
    @State private var people = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    let tipPercentages = [10, 15, 18, 20, 0]
    
    var checkAmount: Double {
        let tip = money / 100 * Double(tipPercentage)
        return money + tip
    }
    
    var checkPerPerson: Double {
        return checkAmount / Double(people + 2)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(.green.gradient).ignoresSafeArea()
                
                Form {
                    Section("How much money") {
                        TextField("Amount", value: $money, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        
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
                        Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                    Section("Amout per person") {
                        Text(checkPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                .navigationTitle(Text("WeSplit6"))
                .toolbar {
                    if isFocused {
                        Button("Done") {
                            isFocused = false
                        }
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
