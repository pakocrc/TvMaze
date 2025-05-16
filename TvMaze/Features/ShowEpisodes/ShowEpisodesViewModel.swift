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
    @Published var displayAlert = false
    @Published var alertMessage = ""
    @Published var isReloadEnabled = false

    let tvShow: TvMazeShow
    let seasons: [TvMazeSeason]
    let networkManager: NetworkProtocol

    init(tvShow: TvMazeShow, seasons: [TvMazeSeason], networkManager: NetworkProtocol) {
        self.tvShow = tvShow
        self.seasons = seasons
        self.networkManager = networkManager
    }

    @MainActor
    func fetchEpisodeList() async {

        do {
            let episodes = try await networkManager.fetchEpisodeList(showId: self.tvShow.id)

            seasonEpisodes = seasons.map({ season in
                return TvMaseSeasonEpisodes(season: season, episodes: episodes.filter({ $0.season == season.number }))
            })

        } catch let error {
            debugPrint(error.localizedDescription)
            displayAlert.toggle()
            isReloadEnabled = true
            alertMessage = error.localizedDescription
        }
    }
}
