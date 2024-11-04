//
//  ContentView.swift
//  DiceRoll
//
//  Created by Galih Samudra on 01/11/24.
//

import Combine
import SwiftUI

struct ContentView: View {
    var sideDices: [Int] {
        Array(4...100).filter( {$0 % 2 == 0})
    }
    @State private var selectedSides = 4
    @State private var totalRoledDice = 4
    @State private var resultRoledDice: [Int] = [0]
    @State private var timer: AnyCancellable?
    @State private var isRollingDice = false
    
    let storageManager: iStorageManager = StorageManager()
    private var roledDices: [Int] = Array(4...8)
    
    
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
                    if isRollingDice {
                        Text("Result Roled dices: \(resultRoledDice.map{ "\($0)" }.joined(separator: " + ")  )")
                    } else {
                        Text("Total roled dices: \(resultRoledDice.map { "\($0)" }.joined(separator: " + ")) \(resultRoledDice == [0] ? "" : "is \(resultRoledDice.reduce(0, +))") ")
                    }
                }
                Section {
                    Button("Roll The Dice") {
                        rollTheDice()
                    }
                    .sensoryFeedback(.impact(flexibility: .soft), trigger: resultRoledDice)
                    .disabled(isRollingDice)
                }
            }
            .navigationTitle("DiceRolls")
        }
        .onAppear {
            loadSavedData()
        }
    }
    
    private func rollTheDice() {
        isRollingDice = true
        totalRoledDice = roledDices.randomElement() ?? 4
        resultRoledDice = []
        if timer != nil {
            timer?.cancel()
        }
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if resultRoledDice.count >= totalRoledDice {
                    timer?.cancel()
                    endRollDice()
                } else {
                    let result = Array(1...selectedSides).randomElement() ?? 4
                    resultRoledDice.append(result)
                }
            }
    }
    
    private func endRollDice() {
        isRollingDice = false
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
