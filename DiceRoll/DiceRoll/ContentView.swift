//
//  ContentView.swift
//  DiceRoll
//
//  Created by Galih Samudra on 01/11/24.
//

import SwiftUI

struct ContentView: View {
    let numbers = [1,2,3,4,5]
    @State var evens = [Int]()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            for number in numbers {
                if number.isMultiple(of: 2) {
                    evens.append(number)
                    print(number)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
