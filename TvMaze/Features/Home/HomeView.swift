//
//  HomeView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 17/4/25.
//

import SwiftUI

//enum ShowNavigationPath {
//    case
//}

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        TabView {
            NavigationStack {
                ShowListView(viewModel: ShowListViewModel())
            }
            .tabItem {
                Label("Shows", systemImage: "play.rectangle")
                    .symbolRenderingMode(.monochrome)
                    .foregroundStyle(.primary)
            }

            NavigationStack {
                Text("Favorites")
            }
                .tabItem {
                    Label("Favorites", systemImage: "star")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.primary)
                }

            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.primary)
                }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
