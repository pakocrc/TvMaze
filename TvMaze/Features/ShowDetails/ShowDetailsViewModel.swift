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
    let coordinator: ShowCoordinatorView

    init(tvShow: TvMazeShow, coordinator: ShowCoordinatorView) {
        self.tvShow = tvShow
        self.coordinator = coordinator

        Task {
            await fetchEpisodeList()
        }
    }

    @MainActor
    func fetchEpisodeList() {
        Task {
            do {
                self.seasons = try await NetworkManager.shared.fetchSeasonList(showId: String(self.tvShow.id))

            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }

    func favoriteSelected() {
        
    }
}
