//
//  HomeView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ShowListView(networkManager: NetworkManager())
                .tabItem {
                    Label("Shows", systemImage: "play.rectangle")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.primary)
                }
                .accessibilityIdentifier("showListViewTabItem")

            FavoritesView(networkManager: NetworkManager())
                .tabItem {
                    Label("Favorites", systemImage: "star")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.primary)
                }
                .accessibilityIdentifier("favoritesViewTabItem")
        }
        .accessibilityIdentifier("homeTabView")
    }
}

#Preview {
    HomeView()
}
