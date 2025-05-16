//
//  ShowEpisodesView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import SwiftUI

struct ShowEpisodesView: View {
    @StateObject var viewModel: ShowEpisodesViewModel
    @State private var isFirstTimeLoading = true

    init(tvShow: TvMazeShow, seasons: [TvMazeSeason], networkManager: NetworkProtocol) {
        self._viewModel = StateObject(wrappedValue: ShowEpisodesViewModel(tvShow: tvShow,
                                                                          seasons: seasons,
                                                                          networkManager: networkManager))
    }

    var body: some View {
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
        .task {
            if isFirstTimeLoading {
                isFirstTimeLoading.toggle()
                await viewModel.fetchEpisodeList()
            }
        }
        .alert("Alert", isPresented: $viewModel.displayAlert, actions: {
            Button("Close", role: .cancel) {
                viewModel.displayAlert.toggle()
            }
        }, message: {
            Text(viewModel.alertMessage)
        })
        .overlay(alignment: .top) {

            if viewModel.seasonEpisodes.isEmpty {
                ContentUnavailableView {
                    Label("Loading", systemImage: "arrow.down.circle.dotted")
                } description: {
                    Text("Retrieving information...")
                } actions: {
                    if viewModel.isReloadEnabled {
                        Button {
                            Task {
                                await viewModel.fetchEpisodeList()
                            }
                        } label: {
                            Text("Reload")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ShowEpisodesView(tvShow: TvMazeStore.getTvShow(),
                     seasons: TvMazeStore.getSeasons(),
                     networkManager: NetworkManager())
}
