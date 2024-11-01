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
    let storageManager: iStorageManager = StorageManager()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack {
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
                    .sensoryFeedback(.impact(flexibility: .soft), trigger: resultRoledDice)
                }
            }
            .navigationTitle("DiceRolls")
        }
        .onAppear {
            loadSavedData()
        }
    }
    
    private func rollTheDice() {
        totalRoledDice = roledDices.randomElement() ?? 4
        resultRoledDice = []
        for _ in 0..<totalRoledDice {
            let result = Array(1...selectedSides).randomElement() ?? 4
            resultRoledDice.append(result)
        }
        saveData()
    }
    
    private func saveData() {
        let dice = DiceResult(selectedSides: selectedSides, totalRoledDice: totalRoledDice, resultRoledDice: resultRoledDice)
        storageManager.save(dice)
    }
    
    private func loadSavedData() {
        if let data = storageManager.load() {
            totalRoledDice = data.totalRoledDice
            resultRoledDice = data.resultRoledDice
            selectedSides = data.selectedSides
        } else {
            totalRoledDice = 4
            resultRoledDice = [0]
            selectedSides = 4
        }
    }
}

#Preview {
    ContentView()
}
