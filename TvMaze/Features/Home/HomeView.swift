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
//            ShowCoordinatorView()
//                .redirect(.showList)
            ShowListView(networkManager: NetworkManager())
                .tabItem {
                    Label("Shows", systemImage: "play.rectangle")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.primary)
                }

//            ShowCoordinatorView()
//                .redirect(.favoritesList)
            FavoritesView(networkManager: NetworkManager())
                .tabItem {
                    Label("Favorites", systemImage: "star")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.primary)
                }
        }
    }
}

#Preview {
    HomeView()
}
