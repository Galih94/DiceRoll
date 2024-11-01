//
//  ContentView.swift
//  DiceRoll
//
//  Created by Galih Samudra on 01/11/24.
//

import SwiftUI

struct ContentView: View {
    var sideDices: [Int] {
        Array(4...100).filter( {$0 % 2 == 0})
    }
    @State private var selectedSides = 4
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack {
                        Text("Selected Dice Sides")
                        Picker("Number of Sides", selection: $selectedSides) {
                            ForEach(sideDices, id: \.self) { side in
                                Text("\(side)-sided").tag(side)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                }
            }
            .navigationTitle("DiceRolls")
        }
    }
}

#Preview {
    ContentView()
}
