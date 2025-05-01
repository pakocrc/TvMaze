//
//  ShowEpisodesView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import SwiftUI

struct ShowEpisodesView: View {
    @StateObject var viewModel: ShowEpisodesViewModel

    init(tvShow: TvMazeShow, seasons: [TvMazeSeason], networkManager: NetworkProtocol) {
        self._viewModel = StateObject(wrappedValue: ShowEpisodesViewModel(tvShow: tvShow,
                                                                          seasons: seasons,
                                                                          networkManager: networkManager))
    }

    var body: some View {
        if viewModel.seasonEpisodes.isEmpty {
            ContentUnavailableView("Loading...", systemImage: "arrow.down.circle.dotted", description: Text("Loading Content"))

        } else {
            List {
                ForEach(viewModel.seasonEpisodes) { seasonEpisodes in
                    Section("Season \(seasonEpisodes.season.number ?? 0)") {
                        if seasonEpisodes.episodes.isEmpty {
                            Text("N/A")
                        } else {
                            ForEach(seasonEpisodes.episodes, id: \.id) { episode in
                                Button {
                                    viewModel.selectedEpisode = episode
                                } label: {
                                    HStack {
                                        Text("\(episode.number ?? 0).")
                                        Text(episode.name ?? "")
                                    }
                                }
                                .foregroundStyle(.primary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(viewModel.tvShow.name ?? "") Seasons")
            .navigationDestination(item: $viewModel.selectedEpisode) { episode in
                EpisodeDetailsView(episode: episode)
            }
        }
    }
}

#Preview {
    ShowEpisodesView(tvShow: TvMazeStore.getTvShow(),
                     seasons: TvMazeStore.getSeasons(),
                     networkManager: NetworkManager())
}
