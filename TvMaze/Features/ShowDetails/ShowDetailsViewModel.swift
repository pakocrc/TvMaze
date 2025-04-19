//
//  ShowDetailsViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

final class ShowDetailsViewModel: ObservableObject {
    @Published var seasons = [TvMazeSeason]()

    let tvShow: TvMazeShow

    init(tvShow: TvMazeShow) {
        self.tvShow = tvShow

        Task {
            await fetchEpisodeList()
        }
    }

    @MainActor
    func fetchEpisodeList() {
        Task {
            do {
#if !DEBUG
                self.seasons = try await TvMazeStore.shared.getMockSeasons()

#else
                self.seasons = try await NetworkManager.shared.fetchSeasonList(showId: String(self.tvShow.id))
#endif

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
