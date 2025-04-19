//
//  FavoritesView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel

    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteShows: [TvMazeShow]

    var body: some View {
        ScrollView {
            if favoriteShows.isEmpty {
                ContentUnavailableView("Empty Favorite Shows", systemImage: "exclamationmark.bubble", description: Text("Add your favorite shows first"))

            } else {
                VStack {
                    ForEach(favoriteShows) { show in
                        ShowRowView(show: show)
                            .frame(height: 200, alignment: .center)
                            .foregroundStyle(.primary)

                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
        }
        .scrollTargetLayout()
        .scrollTargetBehavior(.viewAligned)
        .navigationTitle("TvMaze Favorites")
        .applyNavigation(coordinator: viewModel.coordinator)
    }
}

#Preview {
    FavoritesView(viewModel: FavoritesViewModel(coordinator: FavoritesCoordinatorView()))
        .modelContainer(for: TvMazeShow.self, inMemory: true)
}
