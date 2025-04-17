//
//  TvMazeApp.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI
import SwiftData

@main
struct TvMazeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
        }
//        .modelContainer(sharedModelContainer)
    }
}
