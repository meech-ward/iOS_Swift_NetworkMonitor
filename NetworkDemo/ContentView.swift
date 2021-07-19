//
//  ContentView.swift
//  NetworkDemo
//
//  Created by Sam Meech-Ward on 2021-07-19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var monitor = NetworkMonitor()
    var body: some View {
        VStack {
            Spacer()
            switch monitor.connectionStatus {
            case .connected(let isExpensive, let isConstrained):
                Text("Connected!")
                    .padding()
                Text("Is Expensive: \(isExpensive ? "true" : "false")")
                    .padding()
                Text("Is Constrianed: \(isConstrained ? "true" : "false")")
                    .padding()
            case .disconnected:
                Text("Disconnected")
            case .unknown:
                Text("Unknown")
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
