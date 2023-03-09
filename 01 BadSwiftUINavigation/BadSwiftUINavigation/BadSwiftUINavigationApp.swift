//
//  BadSwiftUINavigationApp.swift
//  BadSwiftUINavigation
//
//  Created by Igor Rosocha on 08.02.2023.
//

import SwiftUI

@main
struct BadSwiftUINavigationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State var isActive = false

    var body: some View {
        NavigationView {
            NavigationLink(
                isActive: $isActive,
                destination: {
                    FirstView()
                },
                label: { Text("Start the flow") }
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct FirstView: View {
    @State var isActive = false
    @State var didAppear = false

    var body: some View {
        NavigationLink(
            isActive: $isActive,
            destination: {
                Text("Last view")
            },
            label: { Text("Go to last view") }
        )
        .task {
            guard !didAppear else { return }
            didAppear = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isActive = true
            }
        }
    }
}
