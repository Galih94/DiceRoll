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
    private var roledDices: [Int] = Array(4...8)
    @State private var totalRoledDice = 4
    @State private var resultRoledDice: [Int] = [0]
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
                Section {
                    Text("Roled dices: \(totalRoledDice) times")
                    Text("Total roled dices: \(resultRoledDice.map { "\($0)" }.joined(separator: " + ")) \(resultRoledDice == [0] ? "" : "is \(resultRoledDice.reduce(0, +))") ")
                }
                Section {
                    Button("Roll The Dice") {
                        rollTheDice()
                    }
                }
            }
            .navigationTitle("DiceRolls")
        }
    }
    
    private func rollTheDice() {
        totalRoledDice = roledDices.randomElement() ?? 4
        resultRoledDice = []
        for i in 0..<totalRoledDice {
            let result = sideDices.randomElement() ?? 4
            resultRoledDice.append(result)
        }
        
    }
}

#Preview {
    ContentView()
}
