//
//  ShowEpisodesViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

final class ShowEpisodesViewModel: ObservableObject {
    @Published var seasonEpisodes = [TvMaseSeasonEpisodes]()
    @Published var selectedEpisode: TvMazeEpisode?

    let tvShow: TvMazeShow
    let seasons: [TvMazeSeason]
    let networkManager: NetworkManager
    let coordinator: ShowCoordinatorView

    init(tvShow: TvMazeShow, seasons: [TvMazeSeason], networkManager: NetworkManager, coordinator: ShowCoordinatorView) {
        self.tvShow = tvShow
        self.seasons = seasons
        self.networkManager = networkManager
        self.coordinator = coordinator

        Task {
            await fetchEpisodeList()
        }
    }

    @MainActor
    func fetchEpisodeList() {
        Task {
            do {
                let episodes = try await networkManager.fetchEpisodeList(showId: self.tvShow.showId.description)

                self.seasonEpisodes = self.seasons.map({ season in
                    return TvMaseSeasonEpisodes(season: season, episodes: episodes.filter({ $0.season == season.number }))
                })

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }


}
