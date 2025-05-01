//
//  FavoritesView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteShows: [TvMazeShow]

    @State var selectedTvShow: TvMazeShow?

    let networkManager: NetworkProtocol

    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                if favoriteShows.isEmpty {
                    ContentUnavailableView("Empty Favorite Shows", systemImage: "exclamationmark.bubble", description: Text("Add your favorite shows first"))
                    
                } else {
                    VStack {
                        ForEach(favoriteShows) { tvShow in
                            Button {
                                selectedTvShow = tvShow
                            } label: {
                                ShowRowView(show: tvShow)
                                    .frame(height: 200, alignment: .center)
                            }
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
            .navigationDestination(item: $selectedTvShow) { tvShow in
                ShowDetailsView(tvShow: tvShow, networkManager: networkManager)
            }
        }
    }
}

#Preview {
    FavoritesView(networkManager: NetworkManager())
        .modelContainer(for: TvMazeShow.self, inMemory: true)
}
