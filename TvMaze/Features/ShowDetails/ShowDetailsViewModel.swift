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

    let tvShow: TvMazeShow
    let networkManager: NetworkManager
    let coordinator: ShowCoordinatorView

    init(tvShow: TvMazeShow, networkManager: NetworkManager, coordinator: ShowCoordinatorView) {
        self.tvShow = tvShow
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
                self.seasons = try await networkManager.fetchSeasonList(showId: String(self.tvShow.showId))

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
