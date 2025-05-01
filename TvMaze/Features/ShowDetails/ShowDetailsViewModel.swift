//
//  ShowDetailsViewModel.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

final class ShowDetailsViewModel: ObservableObject {
    @Published var seasons = [TvMazeSeason]()
    @Published var isPresentingImageFullView = false
    @Published var presentShowEpisodes = false
    @Published var presentShowCast = false

    let tvShow: TvMazeShow
    let networkManager: NetworkProtocol

    init(tvShow: TvMazeShow, networkManager: NetworkProtocol) {
        self.tvShow = tvShow
        self.networkManager = networkManager

        Task {
            await fetchEpisodeList()
        }
    }

    @MainActor
    func fetchEpisodeList() {
        Task {
            do {
                self.seasons = try await networkManager.fetchSeasonList(showId: String(self.tvShow.showId))

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
