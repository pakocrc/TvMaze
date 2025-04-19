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

    init(tvShow: TvMazeShow, seasons: [TvMazeSeason]) {
        self.tvShow = tvShow
        self.seasons = seasons

        Task {
            await fetchEpisodeList()
        }
    }

    @MainActor
    func fetchEpisodeList() {
        Task {
            do {
#if !DEBUG
                let episodes = try await TvMazeStore.shared.getMockEpisodes()
#else
                let episodes = try await NetworkManager.shared.fetchEpisodeList(showId: String(self.tvShow.id))
#endif

                self.seasonEpisodes = self.seasons.map({ season in
                    return TvMaseSeasonEpisodes(season: season, episodes: episodes.filter({ $0.season == season.number }))
                })

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }


}
